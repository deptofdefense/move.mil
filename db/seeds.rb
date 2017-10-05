# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

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

puts 'Loading entitlements...'
entitlements = YAML::load_file(Rails.root.join('db', 'seeds', 'entitlements.yml'))

entitlements.each do |entitlement|
  Entitlement.where(rank: entitlement['rank']).first_or_create(entitlement)
end

puts 'Loading ZIP codes...'
CSV.foreach(Rails.root.join('db', 'seeds', 'zip_code_tabulation_areas.csv'), headers: true) do |row|
  ZipCodeTabulationArea.create(zip_code: row[0], latitude: row[1], longitude: row[2])
end

puts 'Loading shipping offices...'
shipping_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'shipping_offices.json')))

shipping_offices.each do |office|
  ShippingOffice.create(office)
end

puts 'Loading transportation offices...'
transportation_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'transportation_offices.json')))

transportation_offices.each do |office|
  shipping_office_id = ShippingOffice.where(name: office['shipping_office_name']).first.id

  TransportationOffice.create(office.except('shipping_office_name').merge(shipping_office_id: shipping_office_id))
end

puts 'Loading installations...'
installations = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'installations.json')))

installations.each do |installation|
  Installation.create(installation.reject { |key| ['service_name', 'service_code'].include?(key) })
end

puts 'Loading household goods weights...'
hhg_weights = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'hhg_weights.json')))

hhg_weights.each do |category, hhgs|
  hhgs.each do |name, weight|
    HouseholdGood.where(name: name, category: category).first_or_create(name: name, weight: weight, category: category)
  end
end
