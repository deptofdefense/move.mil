class Shorthaul < ApplicationRecord
  def self.rate(date, cwt, distance)
    select(:rate).find_by('effective @> ?::date AND cwt_mi @> ?', date, cwt * distance).rate
  end

  validates :effective, :cwt_mi, :rate, presence: true
end
