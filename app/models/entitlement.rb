class Entitlement < ApplicationRecord
  include FriendlyId

  friendly_id :rank

  validates :rank, :total_weight_self, presence: true
  validates :total_weight_self, numericality: { only_integer: true }
  validates :total_weight_self_plus_dependents, :pro_gear_weight, :pro_gear_weight_spouse, allow_blank: true, numericality: { only_integer: true }
end
