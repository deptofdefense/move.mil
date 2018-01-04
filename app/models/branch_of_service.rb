class BranchOfService < ApplicationRecord
  include FriendlyId

  friendly_id :name

  has_one :branch_of_service_contact, dependent: :destroy
  has_many :service_specific_posts, dependent: :destroy

  accepts_nested_attributes_for :branch_of_service_contact, :service_specific_posts

  validates :name, :display_order, presence: true

  default_scope { order(display_order: :asc) }
end
