class FullPack < ApplicationRecord
  def self.rate(year, schedule, weight)
    select(:rate).find_by('year = ? AND schedule = ? AND weight_lbs @> ?', year, schedule, weight).rate
  end

  validates :year, :schedule, :weight_lbs, :rate, presence: true
end
