class Phone < ApplicationRecord
  belongs_to :office, polymorphic: true

  scope :custsvc_tel, -> { where(name: 'Customer Service').where.not(tel: nil) }
end
