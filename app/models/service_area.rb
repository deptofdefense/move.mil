class ServiceArea < ApplicationRecord
  validates :service_area, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :year, presence: true
end
