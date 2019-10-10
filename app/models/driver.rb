class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :vin, presence: true


  def avg_rating
    sum = 0
    self.trips.each do |trip|
      sum += trip.rating.to_f
    end
    return sum / self.trips.count
  end
end
