FactoryBot.define do
  factory :state do
    # rubocop:disable Style/SymbolProc
    sequence(:abbr) { |n| n.to_s }
    # rubocop:enable Style/SymbolProc
    sequence(:name) { |n| "State #{n}" }
  end
end
