FactoryBot.define do
  factory :tutorial do
    sequence(:title) { |n| "Test Tutorial Title #{n}" }
    sequence(:display_order) { |n| n }

    transient do
      tutorial_step_count 2
    end

    after(:build) do |tutorial, evaluator|
      tutorial.tutorial_steps = build_list(:tutorial_step, evaluator.tutorial_step_count, tutorial: tutorial)
    end
  end
end
