require 'yaml'

module Seeds
  class BranchesOfService
    def seed!
      branches_of_service.each do |branch_of_service|
        BranchOfService.create!(branch_of_service.except('contact', 'posts').merge(branch_of_service_contact_attributes: branch_of_service['contact'], service_specific_posts_attributes: branch_of_service['posts']))
      end
    end

    private

    def branches_of_service
      YAML::load_file(Rails.root.join('lib', 'data', 'branches_of_service.yml'))
    end
  end
end
