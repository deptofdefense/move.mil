FactoryGirl.define do
  sequence(:post_title) { |n| "Test Service Specific Post #{n}" }

  factory :service_specific_post do
    title
    effective_at Date.new(2017, 8, 1)
    branch 'army'
    content 'Some content'
  end
end
