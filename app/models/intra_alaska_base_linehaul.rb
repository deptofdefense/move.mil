class IntraAlaskaBaseLinehaul < ApplicationRecord
  def self.rate(date, distance, weight)
    return rate_lookup(date, distance, weight) unless weight < 1000
    # pro-rate the 1000 lb baseline rate for shipments less than 1000 lbs
    rate_lookup(date, distance, 1000) * (weight / 1000.0)
  end

  def self.rate_lookup(date, distance, weight)
    select(:rate).find_by('effective @> ?::date AND dist_mi @> ? AND weight_lbs @> ?', date, distance, weight).rate
  end

  validates :effective, :dist_mi, :weight_lbs, :rate, presence: true
  private_class_method :rate_lookup
end
