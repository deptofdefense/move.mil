class TopTspByChannelLinehaulDiscount < ApplicationRecord
  def self.inv_discount(orig, dest, date)
    # TODO: return rate from correct performance period
    1.0 - (find_by(orig: orig, dest: dest, year: date.year).perf_period_2 / 100.0)
  end

  validates :orig, :dest, :year, presence: true
end
