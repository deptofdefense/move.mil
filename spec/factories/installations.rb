FactoryBot.define do
  factory :installation do
    sequence(:name) { |n| "Installation #{n}" }

    after(:create) do |installation|
      installation.location = create(:location, locatable: installation)
    end
  end
end
