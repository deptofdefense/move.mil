class TopTspByChannelLinehaulDiscount < ApplicationRecord
  def self.inv_discount(orig, dest, date)
    # TODO: handle out-of-bounds dates
    1.0 - select(:discount).find_by('orig = ? AND dest = ? AND tdl @> ?::date', orig.to_s, dest.to_s, date).discount / 100.0
  end

  validates :orig, :dest, :tdl, :discount, presence: true
end
