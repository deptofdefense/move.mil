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
      # skip blank rows
      next if row[0].blank?

      # CONUS - US rate area (but just the number) and region number
      # US rate area numbers either 2 digits or 7 digits
      # regions go from 1-15
      /\A(?<orig>\d{2}|\d{7})(?<dest>\d\d?)\s*\z/ =~ row[0]

      # OCONUS - rate area to rate area
      # all rate areas start with 2 character all-caps prefix
      # some have digits following, some don't
      /\A(?<orig>[[:upper:]]{2}\d*)\s*(?<dest>[[:upper:]]{2}\d*)\s*\z/ =~ row[0] if $~.nil? # if the previous match failed

      if $~.nil?
        puts 'Could not parse channel named', row[0]
        next
      end

      discounts_by_pp = [row[3], row[5], row[7], row[9], row[11]]
      (0..(dates_by_pp.count - 1)).each do |i|
        next if discounts_by_pp[i].blank?
        TopTspByChannelLinehaulDiscount.where(orig: orig, dest: dest, tdl: dates_by_pp[i]).first_or_initialize.tap do |d|
          d.discount = discounts_by_pp[i] == '#N/A' ? Float::NAN : discounts_by_pp[i]
          d.save
        end
      end
    end
  end
end
