module Locatable
  extend ActiveSupport::Concern

  included do
    acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

    has_one :location, as: :locatable, dependent: :destroy, inverse_of: :locatable

    accepts_nested_attributes_for :location
  end
end
