class Tutorial < ApplicationRecord
  include FriendlyId

  friendly_id :title

  has_many :tutorial_steps

  validates :title, presence: true
end
