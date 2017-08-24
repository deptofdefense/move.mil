# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'nokogiri'

puts 'Loading tutorials...'
tutorials = YAML::load_file(Rails.root.join('db', 'seeds', 'tutorials.yml'))

tutorials.each do |tutorial|
  record = Tutorial.where(title: tutorial['title']).first_or_create

  tutorial['tutorial_steps'].each do |step|
    record.tutorial_steps.where(content: step['content']).first_or_create(step)
  end
end

puts 'Loading FAQs...'
faqs = YAML::load_file(Rails.root.join('db', 'seeds', 'faqs.yml'))

faqs.each do |faq|
  Faq.where(question: faq['question']).first_or_create(faq)
end

puts 'Loading service-specific posts...'
service_specific_posts = YAML::load_file(Rails.root.join('db', 'seeds', 'service_specific_posts.yml'))

service_specific_posts.each do |post|
  ServiceSpecificPost.where(title: post['title']).first_or_create(post)
end

puts 'Loading branch of service contacts...'
branch_of_service_contacts = YAML::load_file(Rails.root.join('db', 'seeds', 'branch_of_service_contacts.yml'))

branch_of_service_contacts.each do |contact|
  BranchOfServiceContact.where(branch: contact['branch']).first_or_create(contact)
end

entitlements = YAML::load_file(Rails.root.join('db', 'seeds', 'entitlements.yml'))

entitlements.each do |entitlement|
  Entitlement.where(rank: entitlement['rank']).first_or_create(entitlement)
end

puts 'Loading ZIP codes...'
CSV.foreach(Rails.root.join('db', 'seeds', '2016_Gaz_zcta_national.txt'), headers: true, col_sep: "\t") do |zipcode|
  z = ZipCodeTabulationArea.find_or_create_by(zipcode: zipcode['GEOID'])
  z.lat = zipcode['INTPTLAT']
  z.lon = zipcode['INTPTLONG']
  z.save
end

puts 'Loading TO and PPSO contact info...'
transportation_offices = Nokogiri::XML(File.open(Rails.root.join('db', 'seeds', 'To_Cntct_Info_201708110930.xml')))
transportation_offices.xpath('//G_CNSL_ORG_ID').each do |node|
  name = node.at('CNSL_NAME').text.strip
  address = node.at('CNSL_ADDR1').text.strip + $/ + node.at('CNSL_ADDR2').text.strip
  city = node.at('CNSL_CITY').text.strip
  state = node.at('CNSL_STATE').text.strip
  postal_code = node.at('CNSL_ZIP').text.strip
  country = node.at('CNSL_COUNTRY').text.strip

  # Does this TO's PPSO already exist?
  ppso = Ppso.where(name: node.at('PPSO_NAME').text.strip).first_or_create do |ppso|
    ppso.address = node.at('PPSO_ADDR1').text.strip + $/ + node.at('PPSO_ADDR2').text.strip
    ppso.city = node.at('PPSO_CITY').text.strip
    ppso.state = node.at('PPSO_STATE').text.strip
    ppso.country = node.at('PPSO_COUNTRY').text.strip
    ppso.postal_code = node.at('PPSO_ZIP').text.strip

    node.css('G_ppso_email').each do |email|
      email_name = email.at('EMAIL_TYPEP').text.strip
      email_address = email.at('EMAIL_ADDRESSP').text.strip

      ppso_email = Email.create(office: ppso, name: email_name, address: email_address)
    end

    ppso.save

    node.css('G_PPSO_PHONE_NOTES').each do |phone|
      phone_name = phone.at('PPSO_PHONE_TYPE').text.strip
      # Does this PPSO already have this phone type with some numbers in it?
      ppso_phone = ppso.phones.find_or_create_by(name: phone_name)
      ppso_phone.notes = phone.at('PPSO_PHONE_NOTES').text.strip
      is_fax = phone.at('PPSO_VOICE_OR_FAX').text.strip == 'F'
      is_dsn = phone.at('PPSO_COMM_OR_DSN').text.strip == 'D'

      # TODO some offices have multiple phone/fax numbers for the same type - change to arrays?

      if is_dsn
        dsn_num = phone.at('PPSO_DSN_NUM').text.strip
        if is_fax
          ppso_phone.fax_dsn = dsn_num
        else
          ppso_phone.tel_dsn = dsn_num
        end
      else
        phone_num = phone.at('PPSO_PHONE_NUM').text.strip
        if is_fax
          ppso_phone.fax = phone_num
        else
          ppso_phone.tel = phone_num
        end
      end

      ppso_phone.save

    end

  end

  transportation_office = TransportationOffice.create(
    ppso: ppso, name: name, address: address, city: city, state: state, postal_code: postal_code, country: country)

  node.css('G_CNSL_EMAIL').each do |email|
    email_name = email.at('EMAIL_TYPE').text.strip
    email_address = email.at('EMAIL_ADDRESS').text.strip

    # Add to email address table
    Email.create(office: transportation_office, name: email_name, address: email_address)
  end

  node.css('G_CNSL_PHONE_NOTES').each do |phone|
    phone_name = phone.at('CNSL_PHONE_TYPE').text.strip
    # Does this PPSO already have this phone type with some numbers in it?
    to_phone = transportation_office.phones.find_or_create_by(name: phone_name)
    to_phone.notes = phone.at('CNSL_PHONE_NOTES').text.strip
    is_fax = phone.at('CNSL_VOICE_OR_FAX').text.strip == 'F'
    is_dsn = phone.at('CNSL_COMM_OR_DSN').text.strip == 'D'

    # TODO some offices have multiple phone/fax numbers for the same type - change to arrays?

    if is_dsn
      dsn_num = phone.at('CNSL_DSN_NUM').text.strip
      if is_fax
        to_phone.fax_dsn = dsn_num
      else
        to_phone.tel_dsn = dsn_num
      end
    else
      phone_num = phone.at('CNSL_PHONE_NUM').text.strip
      if is_fax
        to_phone.fax = phone_num
      else
        to_phone.tel = phone_num
      end
    end

    to_phone.save
  end
end

# Aggregate addresses and ask census.gov for the lat / lon
