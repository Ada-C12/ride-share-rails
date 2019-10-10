class Driver < ApplicationRecord
  has_many :trips, dependent: :destroy
  validates :name, :vin, presence: true
  
  def find_driver_trips
    return self.trips.all
  end
  
  def calculate_total_earnings
    trip_costs = []
    
    self.trips.all.each do |trip|
      trip_costs << (trip.cost - 1.65)
    end
    
    total_cost = trip_costs.sum
    total_revenue = total_cost * 0.8
    return total_revenue
  end
  
  def calculate_average_rating
    
    trip_ratings = []
    
    self.trips.all.each do |trip|
      trip_ratings << trip.rating
      if trip.rating.nil?
        return
      end
    end 
    
    if trip_ratings.nil?
      return
    else 
      total_rating = trip_ratings.sum
      average_rating = total_rating.to_f / trip_ratings.length
    end
    return average_rating
  end
  
  def self.find_available_driver
    driver = Driver.find_by(active: true)
    return driver.id
  end
  
end
