# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'
require 'json'
require 'yaml'

CSV::Converters[:int4range] = lambda{|s|
  begin
    m = /\A(\d+)\.\.(\d+)\z/.match(s)
    if m.present?
      Range.new(m[1].to_i,m[2].to_i)
    else
      s
    end
  end
}

CSV::Converters[:daterange] = lambda{|s|
begin
  m = /\A(\d{4}\-\d{2}\-\d{2})\.\.(\d{4}\-\d{2}\-\d{2})\z/.match(s)
  if m.present?
    (Date.parse(m[1])..Date.parse(m[2]))
  else
    s
  end
end
}

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

puts 'Loading branches of service...'
branches_of_service = YAML::load_file(Rails.root.join('db', 'seeds', 'branches_of_service.yml'))

branches_of_service.each do |branch_of_service|
  branch = BranchOfService.where(name: branch_of_service['name']).first_or_create(name: branch_of_service['name'], display_order: branch_of_service['display_order'])

  branch_of_service['posts'].each do |post|
    branch.service_specific_posts.where(title: post['title']).first_or_create(post)
  end

  branch.branch_of_service_contact = BranchOfServiceContact.create(branch_of_service['contact'])
end

puts 'Loading entitlements...'
entitlements = YAML::load_file(Rails.root.join('db', 'seeds', 'entitlements.yml'))

entitlements.each do |entitlement|
  Entitlement.where(rank: entitlement['rank']).first_or_create(entitlement)
end

puts 'Loading ZIP code centroids...'
areas = CSV.read(Rails.root.join('db', 'seeds', 'zip_code_tabulation_areas.csv'))
columns = [:zip_code, :latitude, :longitude]
ZipCodeTabulationArea.import columns, areas, batch_size: 500

puts 'Loading shipping offices...'
shipping_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'shipping_offices.json')))

shipping_offices.each do |office|
  ShippingOffice.create(office)
end

puts 'Loading transportation offices...'
transportation_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'transportation_offices.json')))

transportation_offices.each do |office|
  shipping_office_id = ShippingOffice.where(name: office['shipping_office_name']).first.id if office['shipping_office_name']

  TransportationOffice.create(office.except('shipping_office_name').merge(shipping_office_id: shipping_office_id))
end

puts 'Loading installations...'
installations = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'installations.json')))

installations.each do |installation|
  Installation.create(installation.reject { |key| ['service_name', 'service_code'].include?(key) })
end

puts 'Loading household goods weights...'
hhg_weights = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'household_goods_weights.json')))

hhg_weights.each do |category|
  hhg_category = HouseholdGoodCategory.where(name: category['name']).first_or_create(name: category['name'], icon: category['icon'])

  category['household_goods'].each do |hhg|
    hhg_category.household_goods.where(name: hhg['name']).first_or_create(name: hhg['name'], weight: hhg['weight'])
  end
end

puts 'Loading ZIP code rate areas, service areas, regions, and basepoint cities...'
zip3s = CSV.read(Rails.root.join('db', 'seeds', 'zip3.csv'))
columns = [:zip3, :basepoint_city, :state, :service_area, :rate_area, :region]
Zip3.import columns, zip3s

zip5s = CSV.read(Rails.root.join('db', 'seeds', 'zip5_rate_areas.csv'))
columns = [:zip5, :rate_area]
Zip5RateArea.import columns, zip5s

puts 'Loading 400NG Baseline Rates...'
schedules = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Geographic_Schedule.csv'), converters: [:numeric, :daterange])
columns = [:service_area, :name, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :effective]
ServiceArea.import columns, schedules

base_linehauls = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Linehaul_CONUS.csv'), converters: [:numeric, :int4range, :daterange])
columns = [:dist_mi, :weight_lbs, :rate, :effective]
BaseLinehaul.import columns, base_linehauls, batch_size: 500

intra_ak_base_linehauls = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Linehaul_IntraAK.csv'), converters: [:numeric, :int4range, :daterange])
columns = [:dist_mi, :weight_lbs, :rate, :effective]
IntraAlaskaBaseLinehaul.import columns, intra_ak_base_linehauls, batch_size: 500

shorthauls = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Shorthaul.csv'), converters: [:numeric, :int4range, :daterange])
columns = [:cwt_mi, :rate, :effective]
Shorthaul.import columns, shorthauls

full_packs = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Full_Pack.csv'), converters: [:numeric, :int4range, :daterange])
columns = [:schedule, :weight_lbs, :rate, :effective]
FullPack.import columns, full_packs

full_unpacks = CSV.read(Rails.root.join('db', 'seeds', '2017_400NG_Full_Unpack.csv'), converters: [:numeric, :daterange])
columns = [:schedule, :rate, :effective]
FullUnpack.import columns, full_unpacks

puts 'Loading ZIP3 to ZIP3 distances from DTOD...'
distances = CSV.read(Rails.root.join('db', 'seeds', 'zip3_dtod_output.csv'), { headers: false, col_sep: ' ' })
columns = [:orig_zip3, :dest_zip3, :dist_mi]
DtodZip3Distance.import columns, distances, { batch_size: 500, validate: false }
