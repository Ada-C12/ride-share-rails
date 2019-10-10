class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

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
