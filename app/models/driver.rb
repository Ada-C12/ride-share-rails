class Driver < ApplicationRecord
  has_many :trips, dependent: :destroy

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
    return (self.trips.sum { |trip| (trip.cost - 165) * 0.8 }) / 100
  end

  def average_rating
    total_rating = 0
    count = 0
    self.trips.each do |trip|
      if trip.rating
        total_rating += trip.rating
        count += 1
      end
    end

    if count == 0
      return "This driver has no ratings"
    else
      return total_rating.to_f / count
    end
  end
end
