class IntraAlaskaBaseLinehaul < ApplicationRecord
  def self.rate(year, distance, weight)
    select(:rate).find_by('year = ? AND dist_mi @> ? AND weight_lbs @> ?', year, distance, weight).rate
  end

  validates :year, :dist_mi, :weight_lbs, :rate, presence: true
end
