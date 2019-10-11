class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, uniqueness: true, presence: true
  
  def earnings
    trips = self.trips
    total_revenue = 0
    trips.each do |trip|
      earned = (trip.cost - 1.65)*0.8
      total_revenue += earned
    end
    total_revenue = total_revenue.round(2)
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
  
  # MADE THIS BEFORE CREATED CUSTOM ROUTE TO CHANGE ACTIVE STATUS ON VIEW FREELY
  # def go_offline
  #   if self.active == true
  #     self.active = false
  #     self.save
  #   end 
  # end 
  
  # def go_online
  #   if self.active == false
  #     self.active = true
  #     self.save
  #   end 
  # end 
end
