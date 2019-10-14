class Driver < ApplicationRecord
  has_many :trips

  def self.alpha_drivers
    return Driver.order(name: :asc)
  end
  validates :name, presence: true
  validates :vin, presence: true

  def self.driver_avg_rating(driver_id)
    
    ratings = []
    
    Trip.where(driver_id: driver_id).each do |trip|
      if trip.rating != nil
        ratings << trip.rating
      end
    end
    
    if ratings != []
      average_rating = ratings.sum.to_f / ratings.length
      return average_rating.round(2)
    else
      average_rating = nil
    end
  end
  
  def self.driver_total_earnings(driver_id)
    # Driver gets 80 percent of trip cost after fee of $1.65 is collected
    earnings = []
    Trip.where(driver_id: driver_id).each do |trip|
      earnings << (trip.cost - 165) * 0.8
    end
    total_earnings = (earnings.sum / 100).round(2)
    return total_earnings
  end
end


  