class HouseholdGood < ApplicationRecord
  validates :weight, :category, presence: true
  validates :name, presence: true, uniqueness: { scope: :category }

  def key
    @key ||= name.gsub(/[^0-9a-z]/i, ' ').strip.gsub(/\s+/, '_').downcase
  end

  def weight_key
    @weight_key ||= key + '_weight'
  end
end
