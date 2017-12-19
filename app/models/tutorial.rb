class Tutorial < ApplicationRecord
  include FriendlyId

  friendly_id :title

  has_many :tutorial_steps, -> { order(:id) }, dependent: :destroy, inverse_of: :tutorial

  validates :title, presence: true

  default_scope { order(id: :asc) }
end
