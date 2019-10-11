class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    trips = self.trips
    completed_trips = trips.select {|t| !t.trip.nil?}
    completed_trips.map do |t|
      trip_cost =  (t - 1.65) * 0.80
    end
    total_earning = completed_trips.sum
    return total_earning
  end
  
  def avg_rating
    trips = self.trips
    count = 0
    completed_trips = trips.select {|trip| !trip.rating.nil?}
    rating = completed_trips.sum {|trip| trip.cost} 
    
    completed_trips = trips.select {|t| !t.rating.nil?}
    rating = completed_trips.sum {|t| t.cost} 
    avg_rating = rating / completed_trips.length
    return avg_rating
  end 
  
  # Change driver to other kind of Driver... this is testing...
  # Update the database for available driver!
  # I'm stil, working on this logic...
  def self.find_a_driver
    # driver = nil
    # driver = Driver.find_by(available: true)
    
    # if driver = nil
    #   return "error"
    # else 
    driver = Driver.first.id
    return driver
  end
end

