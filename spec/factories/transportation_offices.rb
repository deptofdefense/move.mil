FactoryGirl.define do
  sequence(:name) { |n| "Transportation Office #{n}" }

  factory :transportation_office do
    name
    latitude 38.8718568
    # rubocop:disable Lint/AmbiguousOperator
    longitude -77.0584556
    # rubocop:enable Lint/AmbiguousOperator
  end
end
