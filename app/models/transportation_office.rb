class TransportationOffice < ApplicationRecord
  belongs_to :ppso
  has_many :phones, as: :office
  has_many :emails, as: :office
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
