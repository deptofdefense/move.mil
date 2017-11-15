class FullPack < ApplicationRecord
  def self.rate(year, schedule, weight)
    select(:rate).find_by('year = ? AND schedule = ? AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, schedule, weight).rate
  end

  validates :year, :schedule, :weight_lbs_min, :weight_lbs_max, :rate, presence: true
end
