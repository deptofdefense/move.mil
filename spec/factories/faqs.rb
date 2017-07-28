FactoryGirl.define do
  sequence :question { |n| "Test FAQ Question #{n}" }

  factory :faq do
    question
    answer "Answer"
    tags ["tag1", "tag2", "tag3"]
  end
end
