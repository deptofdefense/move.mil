FactoryBot.define do
  factory :location do
    association :locatable

    latitude 38.8718568
    # rubocop:disable Lint/AmbiguousOperator
    longitude -77.0584556
    # rubocop:enable Lint/AmbiguousOperator
  end
end
