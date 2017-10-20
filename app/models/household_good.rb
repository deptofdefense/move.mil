class HouseholdGood < ApplicationRecord
  validates :weight, presence: true
  validates :name, presence: true, uniqueness: { scope: :household_good_category }

  belongs_to :household_good_category

  def key
    @key ||= name.parameterize
  end

  def weight_key
    @weight_key ||= "#{key}_weight"
  end
end
