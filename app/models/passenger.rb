class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def self.all_in_alpha_order
    return Passenger.all.order(name: :asc)
  end
  
  def total_charges
    total_charges = self.trips.map {|t| convert_to_dollars(t.cost) }
    total_charges.compact!
    return total_charges.sum
  end
  
  def convert_to_dollars(pennies)
    if pennies.nil? || pennies == 0
      0.00
    else
      (pennies / 100.0).round(2)
    end
  end

  
end
