FactoryGirl.define do
  sequence :post_title { |n| "Test Service Specific Post #{n}" }

  factory :service_specific_post do
    title
    effective 20170801
    content "Some content"
    branch 'army'
  end
end
