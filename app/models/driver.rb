class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, uniqueness: true, presence: true
  
  def net_earning(trip_cost)
    # Remember trip cost is in number of cents, as in 100 = $1.00, so $1.65 fee deduction is 165.
    return ((trip_cost-165)*0.8).round
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


########### KEEP HERE JUST IN CASE  #################
# def earnings
#### MATH IS OFF B/C trip.cost is in NUMBER OF CENTS, so trip.cost-1.65 is like taking $0.0165 off per transaction when it should've been $1.65
#   ####### THIS TALLIES ALL EXISTING trips, 1-time use NOT for running total! #######
#   ###### Also does NOT account for deleted trips ########
#   ### my version ###
#   trips = self.trips
#   total_revenue = 0
#   trips.each do |trip|
#     earned = (trip.cost - 1.65)*0.8
#     total_revenue += earned
#   end
#   return total_revenue

#   ### your version ###
#   # trips = self.trips
#   # revenue_per_trip = []
#   # trips.each do |trip|
#   #   if trip.rating != nil
#   #     revenue_per_trip << (trip.cost - 1.65)*0.8
#   #   end
#   # end  

#   # if revenue_per_trip.length > 0
#   #   total_revenue = revenue_per_trip.sum.round(2)
#   # else
#   #   return 0
#   # end
#   # return total_revenue
# end 
