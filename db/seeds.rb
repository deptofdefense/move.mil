# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dir[Rails.root.join('db', 'seeds', '*.seeds.rb')].each { |f| require f }

puts '', '== Seeding database =='

puts '-- Seeding branches of service and service-specific posts...'
Seeds::BranchesOfService.new.seed!

puts '-- Seeding entitlements...'
Seeds::Entitlements.new.seed!

puts '-- Seeding FAQs...'
Seeds::Faqs.new.seed!

puts '-- Seeding household goods categories and weights...'
Seeds::HouseholdGoodsCategories.new.seed!

puts '-- Seeding tutorials...'
Seeds::Tutorials.new.seed!

puts '-- Seeding shipping offices...'
Seeds::ShippingOffices.new.seed!

puts '-- Seeding transportation offices...'
Seeds::TransportationOffices.new.seed!

puts '-- Seeding weight scales...'
Seeds::WeightScales.new.seed!

puts '-- Seeding ZIP3s...'
Seeds::Zip3s.new.seed!

puts '-- Seeding ZIP5 rate areas...'
Seeds::Zip5RateAreas.new.seed!

puts '-- Seeding DTOD ZIP3 to ZIP3 distances...'
Seeds::DtodZip3Distances.new.seed!

puts '-- Seeding 2017 400NG baseline rates...'
Seeds::BaselineRates.new(
  date_range: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14')),
  file_path: Rails.root.join('lib', 'data', '2017 400NG Baseline Rates.xlsx')
).seed!

puts '-- Seeding 2018 400NG baseline rates...'
Seeds::BaselineRates.new(
  date_range: Range.new(Date.parse('2018-05-15'), Date.parse('2019-05-14')),
  file_path: Rails.root.join('lib', 'data', '2018 400NG Baseline Rates.xlsx')
).seed!

puts '-- Seeding top TSP by channel linehaul discounts...'
Seeds::TopTspByChannelLinehaulDiscounts.new.seed!
