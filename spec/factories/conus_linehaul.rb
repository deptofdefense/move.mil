FactoryBot.define do
  factory :conus_linehaul do
    dist_mi Range.new(2601, 2700)
    weight_lbs Range.new(1000, 1099)
    rate 3174
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
