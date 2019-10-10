class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, presence: true, uniqueness: true
  
  def average_rating
    total_rating = self.trips.map{|trip| trip.rating }.sum
    if self.trips.length != 0
      return (total_rating.to_f / self.trips.length).round(1)
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
