class Driver < ApplicationRecord
  has_many :trips
  
  ##Validation Code
  validates :name, presence: true;
  validates :vin, presence: true, uniqueness: true
  
  #logic for drivers total earnings here. 
  #logic for drivers average rating here. 
  def average_rating
    average = 0
    count = 0 
    self.trips.each do |trip|
      average += trip.rating.to_i
      count += 1
    end
    return average / count
  end
  
  def total_earnings
    total = 0
    self.trips.each do |trip|
      total += (trip.cost.to_f - 1.65) * 0.80
    end
    # total = total * 0.10
    return total
  end
  
end