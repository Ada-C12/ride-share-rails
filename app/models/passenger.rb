class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def self.alpha_order
    return Passenger.all.order(name: :asc)
  end
  
  def all_trips
    return self.trips.order(date: :desc) 
  end
  
  def format_money(money)
    
  end
  
  def net_expenditures
    #return total amount of money that passenger has spent on their trips
    total = 0
    self.trips.each do |trip|
      unless trip.cost == nil
        total += trip.cost
      end
    end
    return total
  end
  
  def request_trip_params
    trip_date = Time.now
    trip_cost = rand(1000..3000)
    trip_driver_id = Driver.available_driver.id
    
    trip_params = {date: trip_date, cost: trip_cost, driver_id: trip_driver_id}
    return trip_params
  end
  
end
