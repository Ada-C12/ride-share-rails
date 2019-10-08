class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def self.count_rides(driver_id)
    return Trip.where(driver_id: driver_id).count
  end

  def self.average_rating(driver_id)
    trip_array = Trip.where(driver_id: driver_id)
    rating_sum = 0
    trip_array.each do |trip|
      rating_sum += trip[:rating]
    end
    average_rating = rating_sum / count_rides(driver_id)
  end
end
