class Passenger < ApplicationRecord
  has_many :trips
  # add validations here
  validates :name, :phone, presence: true

  def find_passenger_trips
    return self.trips.all
  end

  def amount_charged
    total = 0
    self.trips.all.each do |trip|
      total += trip.cost
    end
    return total
  end
end
