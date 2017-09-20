class TransportationOffice < ApplicationRecord
  acts_as_mappable

  belongs_to :ppso
  has_many :phones, as: :office, dependent: :destroy
  has_many :emails, as: :office, dependent: :destroy
end
