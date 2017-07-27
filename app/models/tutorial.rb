class Tutorial < ApplicationRecord
  validates :title, presence: true

  has_many :tutorial_steps
end
