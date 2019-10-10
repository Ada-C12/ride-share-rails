class Driver < ApplicationRecord
  has_many :trips

  def average_rating
    # driver_trips = self.trips
    rating = 0

    self.trips.each do |trip|
      rating += trip.rating
    end 
    
    return rating 

  end

  def total_earnings
    # driver_trips = self.trips
    earnings = 0
    
    self.trips.each do |trip|
      earnings += trip.cost
    end 

    total_earnings = (earnings - 1.65) * 0.80

    return total_earnings.round(2)
  end

end
