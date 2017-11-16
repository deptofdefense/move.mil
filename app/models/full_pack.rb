class FullPack < ApplicationRecord
  def self.rate(date, schedule, weight)
    select(:rate).find_by('effective @> ?::date AND schedule = ? AND weight_lbs @> ?', date, schedule, weight).rate
  end

  validates :effective, :schedule, :weight_lbs, :rate, presence: true
end
