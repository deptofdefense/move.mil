class FullUnpack < ApplicationRecord
  def self.rate(date, schedule)
    select(:rate).find_by('effective @> ?::date AND schedule = ?', date, schedule).rate
  end

  validates :effective, :schedule, :rate, presence: true
end
