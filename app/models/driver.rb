class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
  
  def average_rating
    ratings = []
    rated_trips = 0

    self.trips.map do |trip| 
      if trip.rating
        ratings << trip.rating
        rated_trips += 1
      end
    end
    
    total_rating = ratings.sum

    if rated_trips != 0
      return (total_rating.to_f / rated_trips).round(1)
    end
    return nil
  end
  
  def total_earnings
    earnings = 0
    self.trips.map do |trip| 
        earnings += (trip.cost > 165) ? trip.cost - 165 : trip.cost
    end

    total_earnings = earnings * 0.8 / 100
    return total_earnings.round(2)
  end
  
  def toggle_active
    self.active = self.active ? false : true
    return self.save
  end
end
