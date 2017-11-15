class TopTspByChannelLinehaulDiscount < ApplicationRecord
  validates :orig, :dest, :year, presence: true
end
