class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true 
  
  def self.alpha_passengers
    return Passenger.order(name: :asc)
  end 
  
  def total_spent
    total = 0
    self.trips.each do |trip|
      total = total + trip.cost
    end
    return '%.2f' % total
  end
end