class Email < ApplicationRecord
  belongs_to :office, polymorphic: true

  scope :custsvc, -> { where(name: 'Customer Service') }
end
