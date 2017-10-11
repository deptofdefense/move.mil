FactoryGirl.define do
  sequence(:name) { |n| "Item #{n}" }

  factory :household_good do
    name
    weight 10
    category 'Living Room'
  end
end
