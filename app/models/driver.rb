class Driver < ApplicationRecord
  has_many :trips
  
  def average_rating
    if self.trips.empty?
      average = nil
    else
      total_rating = 0
      counter = 0
      self.trips.each do |trip|
        total_rating += trip.rating
        counter += 1
      end
      average = (total_rating / counter)
    end
    return average
  end
  
  def total_earnings
    total = 0
    self.trips.each do |trip|
      total += trip.cost
    end
    return total
  end
  
  # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  def driver_earnings
    before_fee = self.total_earnings
    
    if before_fee == 0
      return 0
    end
    
    after_fee = (before_fee - 165)
    
    percentage = 0.8
    driver_earnings = after_fee * percentage
    
    return driver_earnings
  end
  
end
