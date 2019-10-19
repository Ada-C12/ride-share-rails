class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true 
  
  #see the total amount the passenger has been charged
  def request_trip
    date = Date.today
    driver_id = Driver.available.id 
    passenger_id = self.id
    trip_params = {date: date, driver_id: driver_id , passenger_id: passenger_id}  
    return trip_params
  end
  
  def total_charged
    total_trips = self.trips.where.not(cost: nil)
    total_cost = total_trips.map { |trip| trip.cost }.sum
    return total_cost * 0.01
  end
  
end
