class FullUnpack < ApplicationRecord
  validates :effective, :schedule, :rate, presence: true

  def self.rate(date, schedule)
    select(:rate).find_by('effective @> ?::date AND schedule = ?', date, schedule).rate
  end

  def self.effective_date_range
    effective_date_ranges = select(:effective).order(:effective).distinct
    (effective_date_ranges[0].effective.min..effective_date_ranges[-1].effective.max)
  end
end
