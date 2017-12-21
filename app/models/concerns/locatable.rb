module Locatable
  extend ActiveSupport::Concern

  included do
    has_one :location, as: :locatable, dependent: :destroy, inverse_of: :locatable

    accepts_nested_attributes_for :location
  end
end
