require 'yaml'

module Seeds
  class Tutorials
    def seed!
      tutorials.each do |tutorial|
        Tutorial.create!(tutorial.except('tutorial_steps').merge(tutorial_steps_attributes: tutorial['tutorial_steps']))
      end
    end

    private

    def tutorials
      YAML::load_file(Rails.root.join('lib', 'data', 'tutorials.yml'))
    end
  end
end
