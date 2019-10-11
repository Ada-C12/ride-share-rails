class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    total_trips = self.trips.where.not(cost: nil)
    trip_earnings = []
    
    total_trips.each do |trip|  
      single_trip = (trip.cost - 165) * 0.8
      trip_earnings << single_trip
    end
    
    total_earned = trip_earnings.sum * 0.01
    
    return total_earned
    # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  end 
  
  def total_ratings
    total_trips = self.trips.where.not(rating: nil)
    total_rating = total_trips.map { |trip| trip[:rating] }.sum
    return total_rating
    
  end
  
  def self.available
    first_available =  Driver.where(status: nil).first
    first_available.busy 
    return first_available 
  end 
  
  def busy
    self.update(status: true)
  end 
  # When a user deletes a driver associated with a trip, it is up to you and your team on how to deal with "validations"/consequences surrounding the deleted driver and the associated trip
end
