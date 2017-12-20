class WeightScale < ApplicationRecord
  include Locatable

  validates :name, presence: true
end
