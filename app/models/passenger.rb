class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def count_rides
    return self.trips.count
  end

  def total_charges
    trip_array = self.trips
    charge_sum = 0
    trip_array.each do |trip|
      charge_sum += trip[:cost]
    end
    return "%.2f" % charge_sum
  end
end
