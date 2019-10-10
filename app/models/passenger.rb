class Passenger < ApplicationRecord

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
end
