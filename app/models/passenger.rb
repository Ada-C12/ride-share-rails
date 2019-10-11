class Passenger < ApplicationRecord
  

  validates :name, presence: true
  validates :phone_num, presence: true

  has_many :trips
  
  def total_charged
    trips = self.trips
    total = 0
    trips.each do |trip|
      if trip.cost != nil
        total += trip.cost
      end
    end
    return total/100
  end

end
