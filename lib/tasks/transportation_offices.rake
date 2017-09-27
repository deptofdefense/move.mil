namespace :convert do
  desc 'Convert transportation office data from XML to JSON'
  task :transportation_offices do
    puts 'Converting transportation office data from XML to JSON...'

    doc = Nokogiri::XML(File.read(Rails.root.join('db', 'seeds', 'To_Cntct_Info_201708110930.xml')))
    output_file_path = Rails.root.join('db', 'seeds', 'transportation_offices.json')
    transportation_offices = []

    doc.css('G_CNSL_ORG_ID').each do |node|
      name = node.css('CNSL_NAME').text.strip
      street_address = node.at('CNSL_ADDR1').text.strip
      extended_address = node.at('CNSL_ADDR2').text.strip
      locality = node.at('CNSL_CITY').text.strip
      region = node.at('CNSL_ST_DIV').text.strip
      region_code = node.at('CNSL_STATE').text.strip
      postal_code = node.at('CNSL_ZIP').text.strip
      country_name = node.at('CNSL_CTRY_NM').text.strip
      country_code = node.at('CNSL_COUNTRY').text.strip
      email_addresses = []
      phone_numbers = []
      shipping_office_name = node.at('PPSO_NAME').text.strip

      node.css('LIST_G_CNSL_EMAIL_ORG_ID G_CNSL_EMAIL').each do |email|
        email_addresses << {
          email_address: email.at('EMAIL_ADDRESS').text.strip,
          note: email.at('EMAIL_TYPE').text.strip
        }
      end

      node.css('LIST_G_CNSL_PHONE_ORG_ID G_CNSL_PHONE_NOTES').each do |phone|
        phone_number_node = 'CNSL_PHONE_NUM'
        dsn_number_node = 'CNSL_DSN_NUM'
        dsn = phone.at('CNSL_COMM_OR_DSN').text.strip == 'D'
        note = phone.at('CNSL_PHONE_NOTES').text.strip

        obj = {
          phone_number: phone.at(dsn ? dsn_number_node : phone_number_node).text.strip,
          phone_type: phone.at('CNSL_VOICE_OR_FAX').text.strip == 'F' ? 'fax' : 'voice',
          dsn: dsn
        }

        obj['note'] = note if note.length.positive?

        phone_numbers << obj
      end

      transportation_offices << {
        name: name,
        street_address: street_address,
        extended_address: extended_address.length.positive? ? extended_address : nil,
        locality: locality.length.positive? ? locality : nil,
        region: region.length.positive? ? region : nil,
        region_code: region_code.length.positive? ? region_code : nil,
        postal_code: postal_code,
        country_name: country_name,
        country_code: country_code,
        email_addresses: email_addresses.uniq,
        phone_numbers: phone_numbers.uniq,
        shipping_office_name: shipping_office_name
      }
    end

    FileUtils.rm(output_file_path) if File.exist?(output_file_path)

    File.open(output_file_path, 'w') do |f|
      f.write transportation_offices.to_json
    end
  end
end
