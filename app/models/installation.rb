class Installation < ApplicationRecord
  validates :name, presence: true
end
