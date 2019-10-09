class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def self.all_in_alpha_order
    return Driver.all.order(name: :asc)
  end
  
  def earnings
    earnings = self.trips.map {|t| (t.cost - 165) * 0.8 }
    return earnings.sum
  end
  
  def avg_rating
    avg_rating = self.trips.map {|t| t.rating }
    if avg_rating.length == 0
      return "Not rated"
    else
      return avg_rating.sum / avg_rating.count
    end
  end
end
