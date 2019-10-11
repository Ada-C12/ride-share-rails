require 'pry'

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
    binding.pry
    ratings = []
    self.trips.each do |trip|
      ratings << trip.rating
      ratings = ratings.compact
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
  
  #approach 1 - looking through all the trip statuses
  # approach 2- changes status of driver when trip changes -- approach in code  
  # def check_status
  #   self.trips.each do |trip|
  #     if trip.rating = nil 
  #       trip.driver.available = false
  #     else
  #       trip.driver.available = true
  #     end
  #     trip.driver.save
  #   end
  #   return trip.driver.available
  # end
  
  # def change_status
  #   self.trips.each do |trip|
  #     if trip.rating = nil 
  #       trip.driver.available = false
  #     else
  #       trip.driver.available = true
  #     end
  #     trip.driver.save
  #   end  
  #   return driver.available
  # end
end
