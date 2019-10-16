class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  
  def self.new_trip
    available_driver = Driver.all.find { |driver| driver.active == false }
    trip_hash = {
      driver: available_driver,
      date: Date.today,
      cost: rand(1..999).to_i,
    }
    available_driver.update(active: true)
    
    return trip_hash
  end
  
end
