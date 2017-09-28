class FaqsController < ApplicationController
  def index
    return unless grouped_faqs.any?

    @faq_sections = ordered_faq_sections.map do |section|
      {
        slug: section.parameterize,
        title: section,
        faqs: grouped_faqs[section]
      }
    end
  end

  private

  def grouped_faqs
    @grouped_faqs ||= Faq.all.group_by(&:category)
  end

  def ordered_faq_sections
    ['Before You Move', 'Moving Day!']
  end
end
