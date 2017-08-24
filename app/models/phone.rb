class Phone < ApplicationRecord
  belongs_to :office, polymorphic: true
end
