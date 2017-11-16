require 'csv'

namespace :admin do
  desc 'Load linehaul discounts from the top TSP (by BVS) for each channel into the DB'
  task :load_top_tsp_linehaul_discounts, [:discounts_csv_file, :year] => :environment do |_t, args|
    year = args[:year].to_i
    puts "Loading linehaul discounts from the top TSP (by Best Value Score) for each channel for the year #{year}..."

    # date ranges for when the BVS scores from specific performance periods take effect
    dates_by_pp = [
      (Date.new(year, 5, 15)..Date.new(year, 7, 31)),
      (Date.new(year, 8, 1)..Date.new(year, 9, 30)),
      (Date.new(year, 10, 1)..Date.new(year, 12, 31)),
      (Date.new(year + 1, 1, 1)..Date.new(year + 1, 3, 6)),
      (Date.new(year + 1, 3, 7)..Date.new(year + 1, 5, 14))
    ]

    CSV.foreach(args[:discounts_csv_file], headers: true) do |row|
      discounts_by_pp = [row[4], row[6], row[8], row[10], row[12]]
      (0..(dates_by_pp.count - 1)).each do |i|
        next if discounts_by_pp[i].blank?
        TopTspByChannelLinehaulDiscount.where(orig: row[0], dest: row[1], tdl: dates_by_pp[i]).first_or_initialize.tap do |d|
          d.discount = discounts_by_pp[i] == '#N/A' ? Float::NAN : discounts_by_pp[i]
          d.save
        end
      end
    end
  end
end
