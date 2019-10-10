class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, uniqueness: true, presence: true

  def earnings
    trips = self.trips
    revenue_per_trip = []
      trips.each do |trip|
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

  def average_rating
    trips = self.trips
    filtered_ratings = []
      trips.each do |trip|
        if trip.rating != nil
          filtered_ratings << trip.rating
        end
      end
      if filtered_ratings.length > 0
        ratings_total = filtered_ratings.sum
        avg_rating = ((ratings_total + 0.0) / filtered_ratings.length)
      else
        return 0
      end
      avg_rating = avg_rating.round(2)
      return avg_rating
  end 

end
