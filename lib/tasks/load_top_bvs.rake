require 'csv'

namespace :admin do
  desc 'Load linehaul discounts from the top TSP (by BVS) for each channel into the DB'
  task :load_top_bvs, [:bvs_csv_file, :year] => :environment do |t, args|
    puts "Loading linehaul discounts from the top TSP (by Best Value Score) for each channel for the year #{args[:year]}..."
    CSV.foreach(args[:bvs_csv_file], headers: true) do |row|
      bvs = TopBestValueScore.create do |b|
        b.year = args[:year].to_i
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
  end
end
