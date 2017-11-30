FactoryBot.define do
  factory :branch_of_service do
    sequence(:name) { |n| "Branch #{n}" }
    sequence(:display_order) { |n| n }

    transient do
      service_specific_posts_count 2
    end

    after(:build) do |branch_of_service, evaluator|
      create_list(:service_specific_post, evaluator.service_specific_posts_count, branch_of_service: branch_of_service)
      create(:branch_of_service_contact, branch_of_service: branch_of_service)
    end
  end
end
