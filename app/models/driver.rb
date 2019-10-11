class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  # validates :active, presence: true
  validates :car_make, presence: true
  validates :car_model, presence: true
  
  def self.alpha_drivers
    return Driver.order(name: :asc)
  end 
  
  def self.find_available
    return Driver.all.select { |driver| 
    driver.active == false}.sample
  end 
  
  def toggle_status
    self.update(active: !self.active)
  end
  
  def total_earnings
    total = 0
    self.trips.each do |trip|
      total = total + trip.cost
    end
    return '%.2f' % total
  end
  
  def avg_rating
    total_rating = 0
    self.trips.each do |trip|
      total_rating = total_rating + trip.rating
    end
    avg_rating = total_rating.to_f / self.trips.count
    return '%.2f' % avg_rating
  end
end
