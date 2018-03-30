class HouseholdGoodCategory < ApplicationRecord
  has_many :household_goods, dependent: :destroy

  accepts_nested_attributes_for :household_goods

  validates :icon, presence: true
  validates :name, presence: true, uniqueness: true

  default_scope { order(name: :asc) }

  def key
    @key ||= name.parameterize
  end
end
