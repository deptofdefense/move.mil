class TopTspByChannelLinehaulDiscount < ApplicationRecord
  validates :orig, :dest, :tdl, :discount, presence: true

  def self.inv_discount(orig, dest, date)
    1.0 - select(:discount).find_by('orig = ? AND dest = ? AND tdl @> ?::date', orig, dest, date).discount / 100.0
  end

  def self.tdl_date_range
    tdl_date_ranges = select(:tdl).order(:tdl).distinct
    (tdl_date_ranges[0].tdl.min..tdl_date_ranges[-1].tdl.max)
  end
end
