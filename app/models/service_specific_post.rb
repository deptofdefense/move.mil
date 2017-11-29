class ServiceSpecificPost < ApplicationRecord
  validates :title, presence: true

  belongs_to :branch_of_service

  default_scope { order(effective_at: :desc) }
end
