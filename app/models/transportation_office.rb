class TransportationOffice < ApplicationRecord
  belongs_to :ppso
  has_many :phones, as: :office
  has_many :emails, as: :office
end
