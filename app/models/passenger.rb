class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def self.all_in_alpha_order
    return Passenger.all.order(name: :asc)
  end
  
  def total_charges
    total_charges = self.trips.map {|t| t.cost }
    total_charges.compact!
    return total_charges.sum
  end
  
end
