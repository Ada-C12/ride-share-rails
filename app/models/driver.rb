class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    # pull all trips from driver
    driver_trips = self.trips
    # driver.trips
    # iterate and determine total for each trip grab the total cost and do math
    trips_total_cost = 0
    driver_trips.each do |trip|
      trips_total_cost += ((trip.cost - (1.65*100))*0.8)
    end
    
    trips_total_cost /= 100
    trips_total_cost.round(2)
    return trips_total_cost
  end
  
  def average_rating
    driver_trips = self.trips
    all_ratings = []
    driver_trips.each do |trip|
      all_ratings << trip.rating
    end
    return all_ratings.sum/all_ratings.length
  end
end
