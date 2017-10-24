FactoryGirl.define do
  factory :household_good do
    sequence(:name) { |n| "Item #{n}" }
    weight 10
    household_good_category
  end
end
