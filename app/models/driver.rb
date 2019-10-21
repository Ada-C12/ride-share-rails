class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def self.all_in_alpha_order
    return Driver.all.order(name: :asc)
  end
  
  def earnings
    earnings = self.trips.map {|t| ((convert_to_dollars(t.cost) - 1.65) * 0.8).round(2) }
    if earnings.length == 0
      return "No earnings"
    else
      return earnings.sum
    end
  end
  
  def avg_rating
    avg_rating = []
    self.trips.each do |trip|
      if trip.rating != nil
        avg_rating.push(trip.rating)
      end
    end
    if avg_rating.length == 0
      return "Not rated"
    else
      return avg_rating.sum / avg_rating.count
    end
  end
  
  def convert_to_dollars(pennies)
    (pennies / 100.0).round(2)
  end
  
end
