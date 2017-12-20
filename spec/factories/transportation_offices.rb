FactoryBot.define do
  factory :transportation_office do
    sequence(:name) { |n| "Transportation Office #{n}" }

    after(:create) do |transportation_office|
      transportation_office.location = create(:location, locatable: transportation_office)
    end
  end
end
