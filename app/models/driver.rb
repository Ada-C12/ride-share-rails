class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true

  def active
      # returns true is driver is on a trip
      # returns false is driver is available
    available_driver = self.trip.where.not(rating: nil)

    if available_driver.length == 0
      return false 
    else
      true
    end

  
  def total_earnings
    # pull all trips from driver
    driver_trips = self.trips
    # driver.trips
    # iterate and determine total for each trip grab the total cost and do math
    trips_total_cost = 0
    driver_trips.each do |trip|
      if trip.cost != nil
        trips_total_cost += ((trip.cost - (1.65*100))*0.8)
      end
    end
    
    trips_total_cost /= 100
    trips_total_cost.round(2)
    return trips_total_cost
  end
  
  def average_rating
    driver_trips = self.trips
    all_ratings = []
    driver_trips.each do |trip|
      if trip.rating == nil
        all_ratings << 0
      else
        all_ratings << trip.rating
      end
    end
    return all_ratings.sum/all_ratings.length
  end
end
