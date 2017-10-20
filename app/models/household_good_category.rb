class HouseholdGoodCategory < ApplicationRecord
  validates :icon, presence: true
  validates :name, presence: true, uniqueness: true

  has_many :household_goods, dependent: :destroy
end
