class Passenger < ApplicationRecord
  has_many :trips, dependent: :restrict_with_error
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def request_a_ride
    drivers = Driver.all
    driver = drivers.find { |driver| driver.active == nil }
    date = Date.today
    trip_params = {
      driver_id: driver.id,
      passenger_id: self.id,
      date: date
    }
    return trip_params
  end
  
  def total_charge
    total_charge = 0
    self.trips.each do |trip|
      total_charge += trip.cost.to_i
    end
    return total_charge
  end
  
  def complete_trip(trip_id)
    driver = Trip.find_by(id: trip_id).driver
    driver.go_online
  end
end
