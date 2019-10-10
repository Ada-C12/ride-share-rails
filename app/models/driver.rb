class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :vin, presence: true


  def avg_rating
    if self.trips.count == 0
      return 0
    end
    sum = 0
    self.trips.each do |trip|
      sum += trip.rating.to_f
    end
    return sum / self.trips.count
  end

  def total_earnings
    sum = 0
    self.trips.each do |trip|
      sum += trip.cost.to_f
    end
    if sum < 1.65
      return 0
    else return 0.8 * (sum - 1.65)
    end
  end

  def self.find_available
    return self.find_by(active: false)
  end

  def active_toggle
    if self.active
      return self.update(active: false)
    else
      return self.update(active: true)
    end
  end
end
