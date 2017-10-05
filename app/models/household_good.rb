class HouseholdGood < ApplicationRecord
  validates :weight, :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }
end
