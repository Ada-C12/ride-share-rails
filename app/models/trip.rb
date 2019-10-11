require 'pry'

class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  def self.trips_total(passenger_id)
    subtotal = 0
    Trip.where(passenger_id: passenger_id).each do |trip|
      subtotal += trip.cost
    end
    total_price_trips = '%.2f' % (subtotal / 100).round(2)
    return total_price_trips
  end
  
  def self.driver_avg_rating(driver_id)
    ratings = []
    
    Trip.where(driver_id: driver_id).each do |trip|
      ratings << trip.rating
      
    end
    
    average_rating = ratings.sum.to_f / ratings.length
    return average_rating.round(2)
  end
  
  def self.driver_total_earnings(driver_id)
    # Driver gets 80 percent of trip cost after fee of $1.65 is collected
    earnings = []
    Trip.where(driver_id: driver_id).each do |trip|
      earnings << (trip.cost - 165) * 0.8
    end
    total_earnings = '%.2f' % (earnings.sum / 100).round(2)
    return total_earnings
  end

# trip.cost.cents_to_dollars

#   def cents_to_dollars(penny_amount)
#     .to_f / 100
#     return amount_in_dollars
#   end
  
end