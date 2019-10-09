class Driver < ApplicationRecord
<<<<<<< HEAD

  def total_earnings
    trips = self.trips
    completed_trips = trips.select {|t| !t.trip.nil?}
    completed_trips.map do |t|
     trip_cost =  (t - 1.65) * 0.80
    end
    total_earning = completed_trips.sum {|t| t.cost} 
    return total_earning
  end
  
  def avg_rating
    trips = self.trips
   
     count = 0
    completed_trips = trips.select {|t| !t.rating.nil?}
    rating = completed_trips.sum {|t| t.cost} 
    avg_rating = rating / completed_trips.length
    return avg_rating
  end 
end
=======
  has_many :trips
end
>>>>>>> e758e92edfacb8a7e05a7e4f8d02b42f93d4e35c
