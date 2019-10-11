class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  def self.trips_total(passenger_id)
    sum = 0
    Trip.where(passenger_id: passenger_id).each do |trip|
      sum += trip.cost
    end
    return sum
  end

end
