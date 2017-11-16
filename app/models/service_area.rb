class ServiceArea < ApplicationRecord
  def self.find_by_date_and_svc_area_number(date, svc_area_num)
    find_by('effective @> ?::date AND service_area = ?', date, svc_area_num)
  end

  validates :service_area, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :effective, presence: true
end
