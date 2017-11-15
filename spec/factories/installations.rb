FactoryBot.define do
  factory :installation do
    sequence(:name) { |n| "Installation #{n}" }
    latitude 38.6921631
    # rubocop:disable Lint/AmbiguousOperator
    longitude -77.1374000999999
    # rubocop:enable Lint/AmbiguousOperator
  end
end
