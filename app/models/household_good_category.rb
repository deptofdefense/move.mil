class HouseholdGoodCategory < ApplicationRecord
  validates :icon, presence: true
  validates :name, presence: true, uniqueness: true

  has_many :household_goods, dependent: :destroy

  def key
    @key ||= name.parameterize
  end

  def subtotal_key
    @total_key ||= "#{key}_subtotal"
  end

  def total_key
    @total_key ||= "#{key}_total"
  end
end
