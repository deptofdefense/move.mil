require 'yaml'

module Seeds
  class Entitlements
    def seed!
      Entitlement.create!(entitlements)
    end

    private

    def entitlements
      YAML::load_file(Rails.root.join('lib', 'data', 'entitlements.yml'))
    end
  end
end
