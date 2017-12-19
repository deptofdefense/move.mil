FactoryBot.define do
  factory :full_unpack do
    schedule 3
    rate 6.90585
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
