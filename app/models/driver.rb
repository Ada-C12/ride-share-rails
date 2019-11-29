class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: { message: "Name can't be blank"}
  validates :vin, presence: { message: "VIN can't be blank" }
  
  def self.get_available_driver
    first_available = Driver.where(available: true).first
    return first_available
  end
  
  def average_rating
    ratings = []
    
    self.trips.each do |trip|
      ratings.push(trip.rating) if trip.rating
    end
    
    return nil if ratings.length == 0
    
    average_rating = ratings.sum / ratings.length.to_f
    return average_rating.round(2)
  end
  
  def total_earnings
    total_revenue = 0
    
    self.trips.each do |trip|
      if trip.cost && trip.cost > 165
        net_cost = trip.cost - 165
        total_revenue += (net_cost * 0.8).round(2)
      end
    end
    
    converted_earnings = total_revenue / 100.0
    rounded_earnings = converted_earnings.round(2)
    
    return rounded_earnings
  end
  
  def toggle_available
    if self.available
      self.available = false
    else
      self.available = true
    end
    self.save
  end
end
