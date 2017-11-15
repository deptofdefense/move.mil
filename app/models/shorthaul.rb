class Shorthaul < ApplicationRecord
  def self.rate(year, cwt, distance)
    select(:rate).find_by('year = ? AND ? BETWEEN cwt_mi_min AND cwt_mi_max', year, cwt * distance).rate
  end

  validates :year, :cwt_mi_min, :cwt_mi_max, :rate, presence: true
end
