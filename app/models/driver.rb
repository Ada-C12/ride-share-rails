class Driver < ApplicationRecord
  has_many :trips, dependent: :restrict_with_error
  validates :name, presence: true
  validates :vin, presence: true
  def average_rating
    total = 0
    self.trips.each do |trip|
      total += trip.rating.to_f
    end
    return 0 if self.trips.empty?
    return (total / self.trips.length).round(2)
  end
  
  def total_earning
    total = 0 
    self.trips.each do |trip|
      total += ((trip.cost.to_i - 1.65) * 0.8)
    end 
    return total.round(2)
  end
  
  def go_online
    self.active = nil
    self.save
  end
  
  def go_offline
    self.active = true 
    self.save
  end
  
end
