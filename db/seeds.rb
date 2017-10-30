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
CSV.foreach(Rails.root.join('db', 'seeds', 'zip3.csv'), headers: true) do |row|
  Zip3.create(zip3: row['zip3'], basepoint_city: row['basepoint_city'], state: row['state'], service_area: row['service_area'], rate_area: row['rate_area'], region: row['region'], mileage_t: row['mileage_t'], mileage_i: row['mileage_i'])
end

CSV.foreach(Rails.root.join('db', 'seeds', 'zip5_rate_areas.csv'), headers: true) do |row|
  Zip5RateArea.create(zip5: row['zip5'], rate_area: row['rate_area'])
end

CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Geographic_Schedule.csv'), headers:true) do |row|
  ServiceArea.create(service_area: row[0], name: row['name'], services_schedule: row['services_schedule'], linehaul_factor: row['linehaul_factor'], orig_dest_service_charge: row['orig_dest_service_charge'], year: 2017)
end

puts 'Loading Baseline Rates...'
CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Linehaul_CONUS.csv'), headers: true) do |row|
  BaselineRate.create(dist_mi_min: row['dist_mi_min'], dist_mi_max: row['dist_mi_max'], weight_lbs_min: row['weight_lbs_min'], weight_lbs_max: row['weight_lbs_max'], rate: row['rate'], year: 2017)
end

CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Linehaul_IntraAK.csv'), headers: true) do |row|
  IntraAlaskaBaselineRate.create(dist_mi_min: row['dist_mi_min'], dist_mi_max: row['dist_mi_max'], weight_lbs_min: row['weight_lbs_min'], weight_lbs_max: row['weight_lbs_max'], rate: row['rate'], year: 2017)
end

CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Shorthaul.csv'), headers: true) do |row|
  Shorthaul.create(cwt_mi_min: row['cwt_mi_min'], cwt_mi_max: row['cwt_mi_max'], rate: row['rate'], year: 2017)
end

CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Full_Pack.csv'), headers: true) do |row|
  FullPack.create(schedule: row['schedule'], weight_lbs_min: row['weight_lbs_min'], weight_lbs_max: row['weight_lbs_max'], rate: row['rate'], year: 2017)
end

CSV.foreach(Rails.root.join('db', 'seeds', '2017_400NG_Full_Unpack.csv'), headers: true) do |row|
  FullUnpack.create(schedule: row['schedule'], rate: row['rate'], year: 2017)
end

puts 'Loading ZIP3 to ZIP3 distances from DTOD...'
CSV.foreach(Rails.root.join('db', 'seeds', 'zip3_dtod_output.csv'), headers: false, col_sep: ' ') do |row|
  DtodZip3Distance.create(orig_zip3: row[0], dest_zip3: row[1], dist_mi: row[2])
end

puts 'Loading top Best Value Scores for 2017...'
CSV.foreach(Rails.root.join('db', 'seeds', '2017_BVS.csv'), headers: true) do |row|
  bvs = TopBestValueScore.create do |b|
    b.year = 2017
    b.orig = row[0]
    b.dest = row[1]
    b.perf_period_h  = if ((perf_period_h  = row[2]) == '#N/A') then Float::NAN else perf_period_h end
    b.perf_period_hs = if ((perf_period_hs = row[3]) == '#N/A') then Float::NAN else perf_period_hs end
    b.perf_period_1  = if ((perf_period_1  = row[4]) == '#N/A') then Float::NAN else perf_period_1 end
    b.perf_period_1s = if ((perf_period_1s = row[5]) == '#N/A') then Float::NAN else perf_period_1s end
    b.perf_period_2  = if ((perf_period_2  = row[6]) == '#N/A') then Float::NAN else perf_period_2 end
    b.perf_period_2s = if ((perf_period_2s = row[7]) == '#N/A') then Float::NAN else perf_period_2s end
    b.perf_period_3  = if ((perf_period_3  = row[8]) == '#N/A') then Float::NAN else perf_period_3 end
    b.perf_period_3s = if ((perf_period_3s = row[9]) == '#N/A') then Float::NAN else perf_period_3s end
    b.perf_period_4  = if ((perf_period_4  = row[10]) == '#N/A') then Float::NAN else perf_period_4 end
    b.perf_period_4s = if ((perf_period_4s = row[11]) == '#N/A') then Float::NAN else perf_period_4s end
    b.perf_period_5  = if ((perf_period_5  = row[12]) == '#N/A') then Float::NAN else perf_period_5 end
    b.perf_period_5s = if ((perf_period_5s = row[13]) == '#N/A') then Float::NAN else perf_period_5s end
  end
end
