require 'pry'
class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    trips = self.trips
    completed_trips = trips.select {|trip| !trip.cost.nil?}
    completed_trips.map! do |trip|
      trip_cost =  (trip.cost - 1.65) * 0.80
    end
    total_earning = completed_trips.sum
    return total_earning
  end
  
  def avg_rating
    trips = self.trips
    
    count = 0
    completed_trips = trips.select {|trip| !trip.rating.nil?}
    rating = completed_trips.sum {|trip| trip.cost} 
    avg_rating = rating / completed_trips.length
    return avg_rating
  end 
end

