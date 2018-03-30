class Tutorial < ApplicationRecord
  include FriendlyId

  friendly_id :title

  has_many :tutorial_steps, -> { order(:image_path) }, dependent: :destroy, inverse_of: :tutorial

  accepts_nested_attributes_for :tutorial_steps

  validates :title, :display_order, presence: true

  default_scope { order(display_order: :asc) }
end
