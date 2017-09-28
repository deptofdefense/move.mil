FactoryGirl.define do
  sequence(:question) { |n| "Test FAQ Question #{n}" }

  factory :faq do
    question
    answer 'Answer'
    category 'Before You Move'
  end
end
