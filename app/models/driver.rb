class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true

  def count_rides
    return self.trips.count
  end

  def average_rating
    if self.count_rides == 0
      return nil
    else
      trip_array = self.trips
      rating_sum = 0
      trip_array.each do |trip|
        rating_sum += trip[:rating]
      end
      average_rating = rating_sum / count_rides
    end
  end

  def total_earnings
    if self.count_rides == 0
      return nil
    else
      trip_array = self.trips
      earnings_sum = 0
      trip_array.each do |trip|
        earnings_sum += trip[:cost]
        earnings_sum -= 1.65
      end
      total_earning = (earnings_sum * 0.8)
    end
  end
end
