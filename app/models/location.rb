class Location < ApplicationRecord
  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  belongs_to :locatable, inverse_of: :location, polymorphic: true

  validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to: 90 }, presence: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, presence: true

  default_scope { includes(:locatable) }

  self.per_page = 10

  def self.transportation_offices_and_weight_scales_by_distance(latitude:, longitude:)
    where(locatable_type: %w[TransportationOffice WeightScale]).by_distance(origin: [latitude, longitude])
  end
end
