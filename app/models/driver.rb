class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, uniqueness: true

  def self.earnings
    revenue_per_trip = []
      @trips.each do |trip|
        if trip.cost != nil
          revenue_per_trip << (trip.cost - 1.65)*0.8
        end
      end  

      if revenue_per_trip.length > 0
        total_revenue = revenue_per_trip.sum
      else
        return 0
      end
      return total_revenue
  end 

  def self.average_rating
    ratings = []
      @trips.each do |trip|
        if trip.rating != nil
          ratings << trip.rating
        end
      end
      if ratings.length > 0
        ratings_total = ratings.sum
        avg_rating = ((ratings_total + 0.0) / ratings.length)
      else
        return 0
      end
      return avg_rating
  end 

  def self.trips
  end 

end
