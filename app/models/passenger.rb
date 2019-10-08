class Passenger < ApplicationRecord
  
  has_many :trips

  def total_amount
    total = 0

    self.trips.each do |trip|
      cost = trip.cost
      total += cost
      end
      return '%.2f' % total
    end
   
end
