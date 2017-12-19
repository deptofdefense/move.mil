FactoryBot.define do
  factory :top_tsp_by_channel_linehaul_discount do
    orig 'US88'
    dest 'REGION 10'
    tdl Range.new(Date.parse('2017-10-01'), Date.parse('2017-12-31'))
    discount 68.0
  end
end
