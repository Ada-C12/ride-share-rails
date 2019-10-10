class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true
  
  has_many :trips
  
  def total_earnings
    return "0.00" if trips.empty?
    
    dollars, cents = trips.map do |trip|
      ((trip.cost - 165) * 80) / 100
    end.sum.divmod(100)
    
    "#{dollars}.#{cents}"
  end
  
  def average_rating
    return "0.0" if trips.empty?
    
    # ratings = trips.Trip.ratings
    
    ratings = trips.map(&:rating).compact
    
    ((ratings.sum)/ratings.length.to_f).round(1).to_s
    
  end
  
end
