FactoryGirl.define do
  sequence(:question) { |n| "Test FAQ Question #{n}" }

  factory :faq do
    question
    answer 'Answer'
    category 'before-you-move'
  end
end
