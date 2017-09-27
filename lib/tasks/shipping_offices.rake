namespace :convert do
  desc 'Convert shipping office data from XML to JSON'
  task :shipping_offices do
    puts 'Converting shipping office data from XML to JSON...'

    doc = Nokogiri::XML(File.read(Rails.root.join('db', 'seeds', 'To_Cntct_Info_201708110930.xml')))
    output_file_path = Rails.root.join('db', 'seeds', 'shipping_offices.json')
    shipping_offices = []

    doc.css('G_CNSL_ORG_ID').each do |node|
      name = node.at('PPSO_NAME').text.strip
      street_address = node.at('PPSO_ADDR1').text.strip
      extended_address = node.at('PPSO_ADDR2').text.strip
      locality = node.at('PPSO_CITY').text.strip
      region_code = node.at('PPSO_STATE').text.strip
      postal_code = node.at('PPSO_ZIP').text.strip
      country_code = node.at('PPSO_COUNTRY').text.strip
      email_addresses = []
      phone_numbers = []

      node.css('LIST_G_PPSO_EMAIL_ORG_ID G_ppso_email').each do |email|
        email_addresses << {
          email_address: email.at('EMAIL_ADDRESSP').text.strip,
          note: email.at('EMAIL_TYPEP').text.strip
        }
      end

      node.css('LIST_G_PPSO_PHONE_ORG_ID G_PPSO_PHONE_NOTES').each do |phone|
        phone_number_node = 'PPSO_PHONE_NUM'
        dsn_number_node = 'PPSO_DSN_NUM'
        dsn = phone.at('PPSO_COMM_OR_DSN').text.strip == 'D'
        note = phone.at('PPSO_PHONE_NOTES').text.strip

        obj = {
          phone_number: phone.at(dsn ? dsn_number_node : phone_number_node).text.strip,
          phone_type: phone.at('PPSO_VOICE_OR_FAX').text.strip == 'F' ? 'fax' : 'voice',
          dsn: dsn
        }

        obj['note'] = note if note.length.positive?

        phone_numbers << obj
      end

      shipping_offices << {
        name: name,
        street_address: street_address,
        extended_address: extended_address.length.positive? ? extended_address : nil,
        locality: locality.length.positive? ? locality : nil,
        region_code: region_code.length.positive? ? region_code : nil,
        postal_code: postal_code,
        country_code: country_code,
        email_addresses: email_addresses.uniq,
        phone_numbers: phone_numbers.uniq
      }
    end

    FileUtils.rm(output_file_path) if File.exist?(output_file_path)

    File.open(output_file_path, 'w') do |f|
      f.write shipping_offices.uniq.to_json
    end
  end
end
