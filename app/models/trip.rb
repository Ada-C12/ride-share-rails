require 'pry'

class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  def self.trips_total(passenger_id)
    sum = 0
    Trip.where(passenger_id: passenger_id).each do |trip|
      sum += trip.cost
    end
    return sum
  end
  
  def self.driver_avg_rating(driver_id)
    ratings = []
    
    Trip.where(driver_id: driver_id).each do |trip|
      ratings << trip.rating
      
    end
    
    average_rating = ratings.sum.to_f / ratings.length
    return average_rating.round(2)
  end
  
end