class FaqsController < ApplicationController
  def index
    @faqs = Faq.all.group_by(&:category)
  end
end
