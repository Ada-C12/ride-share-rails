class Driver < ApplicationRecord
  has_many :trips
  
  def average_rating
    avg_rating = 0
    if self.trips !=[]
      avg_rating = self.trips.average(:rating).round(1)
    end
    return avg_rating
  end

  def total_earnings
    total_earnings = self.trips.sum{ |trip| (trip.cost - 165) * 0.8 }
    return total_earnings
  end

  def become_unavailable
    self.available = false
    self.save
  end

end
