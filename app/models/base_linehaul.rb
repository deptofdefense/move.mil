class BaseLinehaul < ApplicationRecord
  def self.rate(date, distance, weight)
    select(:rate).find_by('effective @> ?::date AND dist_mi @> ? AND weight_lbs @> ?', date, distance, weight).rate
  end

  validates :effective, :dist_mi, :weight_lbs, :rate, presence: true
end
