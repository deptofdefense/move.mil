FactoryBot.define do
  factory :full_pack do
    schedule 3
    weight_lbs Range.new(0, 16_000)
    rate 65.77
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
