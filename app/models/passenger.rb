class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
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