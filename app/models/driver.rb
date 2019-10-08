class Driver < ApplicationRecord
  
  has_many :trips

  def total_earned
    total = 0

    self.trips.each do |trip|
      cost = trip.cost
      total += cost
      end
      return '%.2f' % total
    end
end
