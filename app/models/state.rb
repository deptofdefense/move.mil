class State < ApplicationRecord
  has_many :zipcodes, dependent: :destroy

  validates :abbr, uniqueness: { case_sensitive: false }, presence: true
  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
