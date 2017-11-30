FactoryBot.define do
  factory :service_specific_post do
    sequence(:title) { |n| "Test Service Specific Post #{n}" }
    effective_at Date.new(2017, 8, 1)
    content 'Some content'
    branch_of_service
  end
end
