class Office < ApplicationRecord
  acts_as_mappable lat_column_name: :latitude, lng_column_name: :longitude

  validates :name, presence: true

  self.per_page = 10
end
