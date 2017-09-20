class Tutorial < ApplicationRecord
  include FriendlyId

  friendly_id :title

  has_many :tutorial_steps, dependent: :destroy

  validates :title, presence: true
end
