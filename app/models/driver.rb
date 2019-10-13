class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earnings
    trip_costs = []
    self.trips.all.each do |trip|
      trip_costs << (trip.cost - 165)
    end 
    
    total_cost = trip_costs.sum
    total_revenue = total_cost * 0.8
    return (total_revenue/100).round(2)
  end
  
  def avg_rating
    avg_rating_hash = []
    avg_rating_on_going = []
    
    self.trips.all.each do |trip|
      if trip.rating.nil?
        avg_rating_on_going << 0
      else
        avg_rating_hash << trip.rating
      end
    end 
    
    if avg_rating_hash.length == 0
      return
    else
      return avg_rating = (avg_rating_hash.sum)/avg_rating_hash.length
    end
  end 
  
  def self.find_a_driver
    driver = Driver.find_by(available: true)
    return driver.id
    
    if driver == nil
      head :not_found
      return
    else 
      return driver.id
    end
  end
end
