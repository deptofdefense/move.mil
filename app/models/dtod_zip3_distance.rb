class DtodZip3Distance < ApplicationRecord
  def self.dist_mi(start_zip3, end_zip3)
    select(:dist_mi).find_by(orig_zip3: start_zip3, dest_zip3: end_zip3).dist_mi if start_zip3.present? && end_zip3.present?
  end

  validates :orig_zip3, :dest_zip3, :dist_mi, presence: true
end
