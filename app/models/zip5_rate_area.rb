class Zip5RateArea < ApplicationRecord
  validates :zip5, :rate_area, presence: true
end
