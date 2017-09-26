class FaqsController < ApplicationController
  def index
    faqs
  end

  private

  def faqs_before_you_move
    @faqs_before_you_move ||= Faq.faqs_before_you_move
  end

  def faqs_moving_day
    @faqs_moving_day ||= Faq.faqs_moving_day
  end

  def faqs_travel_tips
    @faqs_travel_tips ||= Faq.faqs_travel_tips
  end

  def faqs_delivery
    @faqs_delivery ||= Faq.faqs_delivery
  end

  def faqs_after_the_move
    @faqs_after_the_move ||= Faq.faqs_after_the_move
  end

  def faqs
    faqs_before_you_move
    faqs_moving_day
    faqs_travel_tips
    faqs_delivery
    faqs_after_the_move
  end
end
