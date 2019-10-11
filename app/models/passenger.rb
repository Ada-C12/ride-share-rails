class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def find_driver
    driver = Driver.find_by(active: false)
    return driver
  end
  
  def total_paid
    all_trips = self.trips
    total = 0
    all_trips.each do |trip|
      total += trip.cost unless trip.cost.nil?
    end
    
    # convert cents to dollars
    return total / 100
  end
end
