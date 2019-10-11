class Passenger < ApplicationRecord
  has_many :trips, dependent: :restrict_with_error
  validates :name, presence: true
  validates :phone_num, presence: true

  def count_rides
    return self.trips.count
  end

  def total_charges
    if self.count_rides == 0
      return 0
    else
      trip_array = self.trips
      charge_sum = 0
      trip_array.each do |trip|
        charge_sum += trip[:cost]
      end
      return charge_sum.to_f
    end
  end
end
