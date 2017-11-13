FactoryBot.define do
  factory :shipping_office do
    sequence(:name) { |n| "Shipping Office #{n}" }
    latitude 38.8718568
    # rubocop:disable Lint/AmbiguousOperator
    longitude -77.0584556
    # rubocop:enable Lint/AmbiguousOperator
  end
end
