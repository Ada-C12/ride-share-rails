class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  def self.total_money_spent
    # trips = Trip.where(passenger_id: 3)
    
    # total = 0
    
    # trips.each do |trip|
    #   total += trip.cost
    #end
    
    return "blerg"
  end
end
