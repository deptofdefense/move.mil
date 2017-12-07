class Shorthaul < ApplicationRecord
  validates :effective, :cwt_mi, :rate, presence: true

  def self.rate(date, cwt, distance)
    select(:rate).find_by('effective @> ?::date AND cwt_mi @> ?', date, cwt * distance).rate
  end
end
