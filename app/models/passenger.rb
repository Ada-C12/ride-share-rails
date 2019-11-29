class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: { message: "Name can't be blank" }
  validates :phone_num, presence: { message: "Phone number can't be blank" }
  
  def total_money_spent
    trips = self.trips
    
    if trips.nil?
      return 0
    else
      total = trips.sum do |trip|
        trip.cost
      end
      return total / 100.0
    end
  end
end
