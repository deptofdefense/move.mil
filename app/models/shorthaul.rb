class Shorthaul < ApplicationRecord
  def self.rate(year, cwt, distance)
    select(:rate).find_by('year = ? AND ? cwt_mi @> ?', year, cwt * distance).rate
  end

  validates :year, :cwt_mi, :rate, presence: true
end
