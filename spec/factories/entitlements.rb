FactoryBot.define do
  factory :entitlement do
    rank 'E-1'
    total_weight_self 5000
    total_weight_self_plus_dependents 8000
    pro_gear_weight 2000
    pro_gear_weight_spouse 500
  end
end
