class Passenger < ApplicationRecord
  has_many :trips

  def total_amount

    total_charge = 0

    self.trips.each do |trip|
      total_charge += trip.cost
    end 

    return total_charge
  end 
end
