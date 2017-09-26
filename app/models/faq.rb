class Faq < ApplicationRecord
  validates :question, presence: true
  validates :answer, presence: true
  validates :category, presence: true

  scope :faqs_before_you_move, -> { where(category: 'before-you-move') }
  scope :faqs_moving_day, -> { where(category: 'moving-day') }
  scope :faqs_travel_tips, -> { where(category: 'travel-tips') }
  scope :faqs_delivery, -> { where(category: 'delivery') }
  scope :faqs_after_the_move, -> { where(category: 'after-the-move') }
end
