class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def total_cost
    sum = 0
    self.trips.each do |trip|
      if trip.cost != nil
        sum += trip.cost 
      end
    end
    return sum
  end
end