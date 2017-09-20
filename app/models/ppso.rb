class Ppso < ApplicationRecord
  acts_as_mappable

  has_many :phones, as: :office, dependent: :destroy
  has_many :emails, as: :office, dependent: :destroy
end
