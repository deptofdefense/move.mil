class ShippingOffice < ApplicationRecord
  include Locatable

  has_many :transportation_offices, dependent: :destroy

  validates :name, presence: true
end
