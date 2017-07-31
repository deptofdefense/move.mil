class TutorialStep < ApplicationRecord
  validates :content, presence: true

  belongs_to :tutorial
end
