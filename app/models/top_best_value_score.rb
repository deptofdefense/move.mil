class TopBestValueScore < ApplicationRecord
  validates :orig, :dest, :year, presence: true
end
