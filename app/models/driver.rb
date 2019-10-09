class Driver < ApplicationRecord
  has_many :trips
  
  def total_earnings
    return "0.00" if trips.empty?
    
    dollars, cents = trips.map do |trip|
      ((trip.cost - 165) * 80) / 100
    end.sum.divmod(100)
    
    "#{dollars}.#{cents}"
  end
  
  def average_rating
  end
  
end
