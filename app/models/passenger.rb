class Passenger < ApplicationRecord
  has_many :trips
  
  #Validation Code
  validates :name, presence: true;
  validates :phone_num, presence: true, uniqueness: true
  
  def total_spent
    total = 0
    self.trips.each do |trip|
      total += trip.cost.to_f
    end
    # total = total * 0.10
    return total
  end
  
end