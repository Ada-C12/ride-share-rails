
class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  validates :date, presence: true
  validates :cost, numericality: true
  validates :cost, presence: true
  
  def self.trips_total(passenger_id)
    subtotal = 0
    Trip.where(passenger_id: passenger_id).each do |trip|
      subtotal += trip.cost
    end
    total_price_trips = (subtotal / 100).round(2)
    return total_price_trips
  end
end