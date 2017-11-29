class BranchOfService < ApplicationRecord
  include FriendlyId

  friendly_id :name

  has_one :branch_of_service_contacts, dependent: :destroy
  has_many :service_specific_posts, dependent: :destroy

  validates :name, :display:order, presence: true
end
