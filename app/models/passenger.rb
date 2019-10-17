class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :phone_number, presence: true
  
  def total_charged
    passengers_trips = self.trips.map {|trip| trip.cost.to_f }.sum
    return passengers_trips
  end
end
