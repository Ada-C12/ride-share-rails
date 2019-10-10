class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      total += trip.rating
    end

    return total / all_trips.length
  end

  def total_earnings
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      total += trip.cost
    end
    
    return total
  end
end
