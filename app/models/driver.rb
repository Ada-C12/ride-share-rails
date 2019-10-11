class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true
  has_many :trips, dependent: :destroy

  def self.find_available_driver
    all_drivers = self.all

    if all_drivers.empty?
      return nil
    end


    all_drivers.each do |driver|
      if !driver.active
        return driver.id
      end
    end

    return nil
  end

  def average_rating
    ratings = self.trips.where.not(rating: nil).map do |trip|
      trip.rating 
    end

    if ratings.empty?
      return nil
    else
      return ratings.sum / ratings.length
    end
  end

  def trip_count
    return self.trips.count
  end

  def total_earnings
    if self.trips == nil
      return 0
    end

    earnings = self.trips.map do |trip|
      if trip.cost <= 1.65
        0
      else
        (trip.cost - 1.65) * 0.8
      end
    end

    return earnings.sum
  end

  def self.all_in_alpha_order
    return Driver.all.order(name: :asc)
  end

end
