class Driver < ApplicationRecord
  has_many :trips
  
  
  validates_presence_of :name, :vin, message: 'Field cannot be empty!' 
  validates_length_of :vin, :is => 17, message: 'Please enter the correct number of characters!'
  
  def total_earned
    total = 0
    
    self.trips.each do |trip|
      cost = trip.cost
      total += cost
    end
    return '%.2f' % total
  end
  
  def average_rating
    ratings = []
    self.trips.each do |trip|
      ratings << trip.rating
    end
    average = ratings.sum / ratings.count.to_f
    return average.round(2)
  end
  
  def self.assign_driver
    driver = Driver.find_by(available: true)
    driver.available = false
    driver.save
    return driver
  end
  
end
