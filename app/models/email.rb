class Email < ApplicationRecord
  belongs_to :office, polymorphic: true
end
