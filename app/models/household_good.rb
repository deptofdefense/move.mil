class HouseholdGood < ApplicationRecord
  validates :weight, :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }

  def key
    @key ||= name.parameterize
  end

  def weight_key
    @weight_key ||= "#{key}_weight"
  end
end
