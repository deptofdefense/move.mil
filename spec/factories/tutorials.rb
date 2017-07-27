FactoryGirl.define do
  sequence :title { |n| "Test Tutorial Title #{n}" }

  factory :tutorial do
    title

    transient do
      tutorial_step_count 2
    end

    after(:build) do |tutorial, evaluator|
      tutorial.tutorial_steps = build_list(:tutorial_step, evaluator.tutorial_step_count, tutorial: tutorial)
    end
  end
end
