class ZipCodeTabulationArea < ApplicationRecord
  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  validates :zip_code, presence: true, uniqueness: true
  validates :latitude, :longitude, numericality: true, presence: true
end
