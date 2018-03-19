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

require_relative 'seeds/baseline_rates/domestic_400ng'

puts 'Loading tutorials...'
tutorials = YAML::load_file(Rails.root.join('db', 'seeds', 'tutorials.yml'))

tutorials.each do |tutorial|
  record = Tutorial.where(title: tutorial['title']).first_or_create!(title: tutorial['title'], display_order: tutorial['display_order'])

  tutorial['tutorial_steps'].each do |step|
    record.tutorial_steps.where(content: step['content']).first_or_create!(step)
  end
end

puts 'Loading FAQs...'
faqs = YAML::load_file(Rails.root.join('db', 'seeds', 'faqs.yml'))

faqs.each do |faq|
  Faq.where(question: faq['question']).first_or_create!(faq)
end

puts 'Loading branches of service...'
branches_of_service = YAML::load_file(Rails.root.join('db', 'seeds', 'branches_of_service.yml'))

branches_of_service.each do |branch_of_service|
  branch = BranchOfService.where(name: branch_of_service['name']).first_or_create!(name: branch_of_service['name'], display_order: branch_of_service['display_order'])

  branch_of_service['posts'].each do |post|
    branch.service_specific_posts.where(title: post['title']).first_or_create!(post)
  end

  branch.create_branch_of_service_contact!(branch_of_service['contact'])
end

puts 'Loading entitlements...'
entitlements = YAML::load_file(Rails.root.join('db', 'seeds', 'entitlements.yml'))

entitlements.each do |entitlement|
  Entitlement.where(rank: entitlement['rank']).first_or_create!(entitlement)
end

puts 'Loading shipping offices...'
shipping_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'shipping_offices.json')))

shipping_offices.each do |office|
  ShippingOffice.create!(office.except('location').merge(location_attributes: office['location']))
end

puts 'Loading transportation offices...'
transportation_offices = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'transportation_offices.json')))

transportation_offices.each do |office|
  shipping_office_id = ShippingOffice.where(name: office['shipping_office_name']).try(:first).try(:id)

  TransportationOffice.create!(office.except('location', 'shipping_office_name').merge(location_attributes: office['location'], shipping_office_id: shipping_office_id))
end

puts 'Loading weight scales...'
weight_scales = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'weight_scales.json')))

weight_scales.each do |weight_scale|
  WeightScale.create!(weight_scale.except('location').merge(location_attributes: weight_scale['location']))
end

puts 'Loading household goods weights...'
hhg_weights = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'household_goods_weights.json')))

hhg_weights.each do |category|
  hhg_category = HouseholdGoodCategory.where(name: category['name']).first_or_create!(name: category['name'], icon: category['icon'])

  category['household_goods'].each do |hhg|
    hhg_category.household_goods.where(name: hhg['name']).first_or_create!(name: hhg['name'], weight: hhg['weight'])
  end
end

puts 'Loading ZIP code rate areas, service areas, regions, and basepoint cities...'
zip3s = CSV.read(Rails.root.join('db', 'seeds', 'zip3.csv'))
Zip3.import [:zip3, :basepoint_city, :state, :service_area, :rate_area, :region], zip3s

zip5s = CSV.read(Rails.root.join('db', 'seeds', 'zip5_rate_areas.csv'))
Zip5RateArea.import [:zip5, :rate_area], zip5s

puts 'Loading 400NG Baseline Rates for 2017...'
daterange = (Date.parse('2017-05-15')..Date.parse('2018-05-14'))
rates = Seeds::BaselineRates::Domestic400NG.new(Rails.root.join('db', 'seeds', '2017 400NG Baseline Rates.xlsx').to_s, daterange)

ServiceArea.import [:service_area, :name, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :effective], rates.schedules
FullPack.import [:schedule, :weight_lbs, :rate, :effective], rates.full_packs
FullUnpack.import [:schedule, :rate, :effective], rates.full_unpacks
Shorthaul.import [:cwt_mi, :rate, :effective], rates.shorthauls
ConusLinehaul.import [:dist_mi, :weight_lbs, :rate, :effective], rates.conus_linehauls, batch_size: 500
IntraAlaskaLinehaul.import [:dist_mi, :weight_lbs, :rate, :effective], rates.intra_ak_linehauls, batch_size: 500

puts 'Loading 400NG Baseline Rates for 2018...'
daterange = (Date.parse('2018-05-15')..Date.parse('2019-05-14'))
rates = Seeds::BaselineRates::Domestic400NG.new(Rails.root.join('db', 'seeds', '2018 400NG Baseline Rates.xlsx').to_s, daterange)

ServiceArea.import [:service_area, :name, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :effective], rates.schedules
FullPack.import [:schedule, :weight_lbs, :rate, :effective], rates.full_packs
FullUnpack.import [:schedule, :rate, :effective], rates.full_unpacks
Shorthaul.import [:cwt_mi, :rate, :effective], rates.shorthauls
ConusLinehaul.import [:dist_mi, :weight_lbs, :rate, :effective], rates.conus_linehauls, batch_size: 500
IntraAlaskaLinehaul.import [:dist_mi, :weight_lbs, :rate, :effective], rates.intra_ak_linehauls, batch_size: 500

puts 'Loading ZIP3 to ZIP3 distances from DTOD...'
distances = CSV.read(Rails.root.join('db', 'seeds', 'zip3_dtod_output.csv'), { headers: false, col_sep: ' ' })
DtodZip3Distance.import [:orig_zip3, :dest_zip3, :dist_mi], distances, { batch_size: 500, validate: false }

puts 'Loading discounts from top TSP (by BVS) per channel...'
if ENV['SEEDS_ENC_IV'].blank? || ENV['SEEDS_ENC_KEY'].blank?
  STDERR.puts 'Cannot load encrypted discounts file; ensure that both SEEDS_ENC_IV and SEEDS_ENC_KEY are set in your environment (check .env file)'
else
  cipher = OpenSSL::Cipher::AES256.new :CBC
  cipher.decrypt
  cipher.iv = [ENV['SEEDS_ENC_IV']].pack('H*')
  cipher.key = [ENV['SEEDS_ENC_KEY']].pack('H*')

  # path, year, and tdl. Remember that rates take effect May 15, so the two
  # TDLs before that date belong to the previous year
  discount_files = [
    [Rails.root.join('db', 'seeds', 'No 1 BVS Dom Discounts - Eff 1Oct2017.csv.enc'), 2017, 2],
    [Rails.root.join('db', 'seeds', 'No 1 BVS Dom Discounts - Eff 1Jan2018.csv.enc'), 2017, 3]
  ]

  discount_files.each do |path, year, tdl|
    discounts_csv = cipher.update(File.read(path))
    discounts_csv << cipher.final

    # after each discounts file, reset the cipher to read more files
    cipher.reset

    # date ranges for when the BVS scores from specific performance periods take effect
    dates_by_tdl = [
      (Date.new(year, 5, 15)..Date.new(year, 7, 31)),
      (Date.new(year, 8, 1)..Date.new(year, 9, 30)),
      (Date.new(year, 10, 1)..Date.new(year, 12, 31)),
      (Date.new(year + 1, 1, 1)..Date.new(year + 1, 3, 6)),
      (Date.new(year + 1, 3, 7)..Date.new(year + 1, 5, 14))
    ]

    tdl_daterange = dates_by_tdl[tdl]

    discounts = CSV.parse(discounts_csv, headers: true)
    discounts.each do |row|
      TopTspByChannelLinehaulDiscount.where(orig: row['ORIGIN'], dest: row['DESTINATION'], tdl: tdl_daterange).first_or_initialize.tap do |d|
        d.discount = row['LH_RATE']
        d.save
      end
    end
  end
end

puts 'Loading ZIP code metadata...'
puts ">>> Seed states table..."
# From https://github.com/midwire/free_zipcode_data/raw/master/all_us_states.csv
states = CSV.read(Rails.root.join('db', 'seeds', 'all_us_states.csv'), :return_headers => false)
State.import states[0], states.slice(1, states.length - 1)

state_ids_by_abbr = State.pluck(:abbr, :id).to_h

puts ">>> Seed counties table..."
# From https://github.com/midwire/free_zipcode_data/raw/master/all_us_counties.csv
unmapped_counties = CSV.read(Rails.root.join('db', 'seeds', 'all_us_counties.csv'), :return_headers => false)
counties = unmapped_counties.slice(1, unmapped_counties.length - 1).map { |c| [c[0], state_ids_by_abbr[c[1]], c[2]] }
County.import [:name, :state_id, :county_seat], counties

puts ">>> Seed zipcodes table..."
# From https://github.com/midwire/free_zipcode_data/raw/master/all_us_zipcodes.csv
zipcodes = []
CSV.foreach(Rails.root.join('db', 'seeds', 'all_us_zipcodes.csv'), :headers => true) do |row|
  state_id = state_ids_by_abbr[row['state']]
  begin
    county = County.find_by_name_and_state_id!(row['county'], state_id)
  rescue Exception => e
    puts ">>> e: [#{e}]"
    puts ">>>> No county found for zipcode: [#{row['code']}], '#{row['city']}, #{row['state']}, #{row['county']}... SKIPPING..."
    next
  end
  zipcodes << [row['code'],
    row['city'].titleize,
    state_id,
    county.id,
    row['lat'],
    row['lon']
  ]
end
Zipcode.import [:code, :city, :state_id, :county_id, :lat, :lon], zipcodes
