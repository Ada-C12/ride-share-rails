class Trip < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver, optional: true
  
  def self.all_trips
    return self.all.order(date: :desc)
  end
  
  # def set_trip_params
  #   trip_date = Date.today
  #   trip_cost = rand(1000..3000)
  #   trip_driver_id = Driver.available_driver.id
  
  #   trip_params = {trip: {date: trip_date, cost: trip_cost, driver_id: trip_driver_id}}
  #   return trip_params
  # end
end
