class Installation < ApplicationRecord
  include Locatable

  validates :name, presence: true
end
