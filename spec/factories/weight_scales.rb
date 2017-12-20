FactoryBot.define do
  factory :weight_scale do
    sequence(:name) { |n| "Weight Scale #{n}" }

    after(:create) do |weight_scale|
      weight_scale.location = create(:location, locatable: weight_scale)
    end
  end
end
