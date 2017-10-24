class HouseholdGood < ApplicationRecord
  validates :weight, presence: true
  validates :name, presence: true, uniqueness: { scope: :household_good_category_id }

  belongs_to :household_good_category
  validates :household_good_category, presence: true

  def key
    @key ||= name.parameterize
  end

  def weight_key
    @weight_key ||= "#{key}_weight"
  end
end
