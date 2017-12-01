class Entitlement < ApplicationRecord
  include FriendlyId

  friendly_id :rank

  validates :rank, :total_weight_self, :total_weight_self_plus_dependents, presence: true
  validates :total_weight_self, :total_weight_self_plus_dependents, numericality: { only_integer: true }
  validates :pro_gear_weight, :pro_gear_weight_spouse, allow_blank: true, numericality: { only_integer: true }
end
