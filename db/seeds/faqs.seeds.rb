require 'yaml'

module Seeds
  class Faqs
    def seed!
      Faq.create!(faqs)
    end

    private

    def faqs
      YAML.load_file(Rails.root.join('lib', 'data', 'faqs.yml'))
    end
  end
end
