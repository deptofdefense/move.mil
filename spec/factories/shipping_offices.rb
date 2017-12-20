FactoryBot.define do
  factory :shipping_office do
    sequence(:name) { |n| "Shipping Office #{n}" }

    after(:create) do |shipping_office|
      shipping_office.location = create(:location, locatable: shipping_office)
    end
  end
end
