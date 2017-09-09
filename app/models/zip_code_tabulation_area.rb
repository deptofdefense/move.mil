class ZipCodeTabulationArea < ApplicationRecord
  acts_as_mappable

  validates :zipcode, presence: true, uniqueness: true
  validates :lat, :lng, numericality: true, presence: true
end
