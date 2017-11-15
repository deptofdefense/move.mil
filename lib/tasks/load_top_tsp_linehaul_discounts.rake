require 'csv'

namespace :admin do
  desc 'Load linehaul discounts from the top TSP (by BVS) for each channel into the DB'
  task :load_top_tsp_linehaul_discounts, [:discounts_csv_file, :year] => :environment do |_t, args|
    puts "Loading linehaul discounts from the top TSP (by Best Value Score) for each channel for the year #{args[:year]}..."
    CSV.foreach(args[:discounts_csv_file], headers: true) do |row|
      TopTspByChannelLinehaulDiscount.create do |b|
        b.year = args[:year].to_i
        b.orig = row[0]
        b.dest = row[1]
        b.perf_period_h  = (perf_period_h  = row[2]) == '#N/A' ? Float::NAN : perf_period_h
        b.perf_period_hs = (perf_period_hs = row[3]) == '#N/A' ? Float::NAN : perf_period_hs
        b.perf_period_1  = (perf_period1  = row[4]) == '#N/A' ? Float::NAN : perf_period1
        b.perf_period_1s = (perf_period1s = row[5]) == '#N/A' ? Float::NAN : perf_period1s
        b.perf_period_2  = (perf_period2  = row[6]) == '#N/A' ? Float::NAN : perf_period2
        b.perf_period_2s = (perf_period2s = row[7]) == '#N/A' ? Float::NAN : perf_period2s
        b.perf_period_3  = (perf_period3  = row[8]) == '#N/A' ? Float::NAN : perf_period3
        b.perf_period_3s = (perf_period3s = row[9]) == '#N/A' ? Float::NAN : perf_period3s
        b.perf_period_4  = (perf_period4  = row[10]) == '#N/A' ? Float::NAN : perf_period4
        b.perf_period_4s = (perf_period4s = row[11]) == '#N/A' ? Float::NAN : perf_period4s
        b.perf_period_5  = (perf_period5  = row[12]) == '#N/A' ? Float::NAN : perf_period5
        b.perf_period_5s = (perf_period5s = row[13]) == '#N/A' ? Float::NAN : perf_period5s
      end
    end
  end
end
