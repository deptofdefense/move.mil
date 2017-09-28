class Faq < ApplicationRecord
  validates :question, :answer, :category, presence: true
end
