FactoryBot.define do
  factory :transportation_office do
    sequence(:name) { |n| "Transportation Office #{n}" }
    latitude 38.8718568
    # rubocop:disable Lint/AmbiguousOperator
    longitude -77.0584556
    # rubocop:enable Lint/AmbiguousOperator
  end
end
