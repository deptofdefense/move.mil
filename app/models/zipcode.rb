class Zipcode < ApplicationRecord
  belongs_to :state

  validates :code, uniqueness: true, presence: true
  validates :city, :state_id, presence: true

  def latlon
    [lat, lon]
  end
end
