class TransportationOffice < ApplicationRecord
  include Locatable

  belongs_to :shipping_office, optional: true

  validates :name, presence: true

  default_scope { includes(:shipping_office) }
end
