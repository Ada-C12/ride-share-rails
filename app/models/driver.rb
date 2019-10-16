class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def total_earning
    sum = 0
    self.trips.each do |trip|
      if trip.cost != nil
        sum += (trip.cost - 1.65) * 0.8
      end
    end
    return sum.to_i
  end
  
  def average_rating
    sum = 0
    count = 0
    self.trips.each do |trip|
      if trip.rating != nil
        sum += (trip.rating)
        count += 1
      end
    end
    
    if count == 0
      return "There is no rating info avaliable"
    else
      return (sum / count)
    end
  end

end