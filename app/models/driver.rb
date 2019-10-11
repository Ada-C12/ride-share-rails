class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def average_rating
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      total += trip.rating unless trip.rating.nil?
    end
    
    if all_trips.length  > 0
      return total / all_trips.length 
    else
      return nil
    end
  end
  
  def total_earnings
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      trip_cost = (trip.cost - 165) * 0.80
      total += trip_cost unless trip.cost.nil?
    end
    
    # convert cents to dollars
    return total / 100
  end
  
  def toggle_active
    self.active = self.active ? false : true
    self.save
  end
end
