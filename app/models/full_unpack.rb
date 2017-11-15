class FullUnpack < ApplicationRecord
  def self.rate(year, schedule)
    select(:rate).find_by(year: year, schedule: schedule).rate
  end

  validates :year, :schedule, :rate, presence: true
end
