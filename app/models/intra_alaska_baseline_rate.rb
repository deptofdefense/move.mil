class IntraAlaskaBaselineRate < ApplicationRecord
  def self.rate(year, distance, weight)
    select(:rate).find_by('year = ? AND ? BETWEEN dist_mi_min AND dist_mi_max AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, distance, weight).rate
  end

  validates :year, :dist_mi_min, :dist_mi_max, :weight_lbs_min, :weight_lbs_max, :rate, presence: true
end
