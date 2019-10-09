class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true
  def average_rating
    total = 0
    self.trips.each do |trip|
      total += trip.rating.to_f
    end
    return (total / self.trips.length).round(2)
  end
  
  def total_earning
    total = 0 
    self.trips.each do |trip|
      total += trip.cost.to_i
    end 
    return total 
  end
  
  def go_online
  end
  
  def go_offline
  end
  
end
