FactoryGirl.define do
  factory :household_good_category do
    sequence(:name) { |n| "Category #{n}" }
    icon 'icons/bedroom.svg'

    transient do
      household_goods_count 3
    end

    after(:build) do |household_good_category, evaluator|
      create_list(:household_good, evaluator.household_goods_count, household_good_category: household_good_category)
    end
  end
end
