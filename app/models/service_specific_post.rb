class ServiceSpecificPost < ApplicationRecord
  validates :title, presence: true

  default_scope { order(effective_at: :desc) }
end
