class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    trip_costs = []
    self.trips.all.each do |trip|
      trip_costs << (trip.cost - 1.65)
    end 
    
    total_cost = trip_costs.sum
    total_revenue = total_cost * 0.8
    return (total_revenue/100).round(2)
  end
  
  def avg_rating
    avg_rating = []
    self.trips.all.each do |trip|
      avg_rating << (trip.rating)
    end
    
    avg_rating = (avg_rating.sum)/avg_rating.length
    return avg_rating
  end 
  
  def self.find_a_driver
    driver = Driver.find_by(available: true)
    return driver.id
    
    if driver = nil
      return "Error"
    else 
      return driver.id
    end
  end
end 
