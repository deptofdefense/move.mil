class Zip3 < ApplicationRecord
  validates :zip3, :basepoint_city, :state, :service_area, :rate_area, :region, presence: true
end
