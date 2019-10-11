class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true, format: {with: /[a-zA-Z]/} 
  validates :vin, presence: true
  
  def avg_rating
    driver_trips = self.trips
    if driver_trips.empty?
      return nil
    end
    
    summed_ratings = 0
    
    in_progress_trips = 0
    driver_trips.each do |trips|
      if trips.rating.nil?
        in_progress_trips += 1
      else
        summed_ratings += trips.rating
      end
    end
    
    
    average_rating = summed_ratings / (driver_trips.length - in_progress_trips)
    return average_rating
  end
  
  def total_earnings
    driver_trips = self.trips
    earnings = 0
    
    driver_trips.each do |trips|
      fee = (trips.cost - 1.65)
      driver_earnings = fee * 0.8
      earnings += driver_earnings
    end
    return earnings
  end
end
