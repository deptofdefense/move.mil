class Ppso < ApplicationRecord
  acts_as_mappable

  has_many :phones, as: :office
  has_many :emails, as: :office
end
