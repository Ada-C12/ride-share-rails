class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def average_rating
    total_rating = self.trips.map{|trip| trip.rating }.sum
    if self.trips.length != 0
      return (total_rating.to_f / self.trips.length).round(1)
    end
    return nil
  end
  
  def total_earnings
    total_earnings = self.trips.map {|trip| trip.cost}.sum / 100.0
    return total_earnings.round(2)
  end
  
  def toggle_active
    self.active = self.active ? false : true
    return self.save
  end
end
