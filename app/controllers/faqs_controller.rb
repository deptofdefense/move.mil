class FaqsController < ApplicationController
  def index
    faqs
  end

  private

  def faqs
    @faqs ||= Faq.all
  end
end
