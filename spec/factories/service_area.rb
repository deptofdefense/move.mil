FactoryBot.define do
  factory :service_area do
    service_area 56
    name 'Los Angeles, CA'
    services_schedule 3
    linehaul_factor 2.63
    orig_dest_service_charge 7.59
    effective Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))
  end
end
