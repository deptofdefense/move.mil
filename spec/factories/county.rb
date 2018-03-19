FactoryBot.define do
  factory :county do
    sequence(:name) { |n| "County #{n}" }
    state
  end
end
