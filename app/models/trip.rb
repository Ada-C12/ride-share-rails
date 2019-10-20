class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :passenger_id, presence: true
  validates :driver_id, presence: true
  validates :date, presence: true

  def self.chrono_trips
    return Trip.order(date: :desc)
  end
end

