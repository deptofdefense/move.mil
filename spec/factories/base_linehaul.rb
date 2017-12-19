FactoryBot.define do
  factory :base_linehaul do
    dist_mi Range.new(2501, 2600)
    weight_lbs Range.new(1000, 1099)
    rate 3118
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
