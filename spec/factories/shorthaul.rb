FactoryBot.define do
  factory :shorthaul do
    cwt_mi Range.new(0, 16_000)
    rate 321.63
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
