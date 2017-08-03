class ServiceSpecificPost < ApplicationRecord
  validates :title, presence: true

  default_scope { order(:effective_at).reverse_order }

  scope :posts_army, -> { where(branch: 'army') }
  scope :posts_air_force, -> { where(branch: 'air_force') }
  scope :posts_navy, -> { where(branch: 'navy') }
  scope :posts_marine_corps, -> { where(branch: 'marine_corps') }
  scope :posts_coast_guard, -> { where(branch: 'coast_guard') }
end
