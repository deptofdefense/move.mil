class HouseholdGood < ApplicationRecord
  belongs_to :household_good_category

  validates :household_good_category, presence: true
  validates :name, presence: true, uniqueness: { scope: :household_good_category_id }
  validates :weight, presence: true

  default_scope { order(name: :asc) }

  def key
    @key ||= name.parameterize
  end

  def weight_key
    @weight_key ||= "#{key}_weight"
  end
end
