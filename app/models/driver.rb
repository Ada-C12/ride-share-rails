class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true

  def active
      # returns true is driver is on a trip
      # returns false is driver is available
    available_driver = self.trip.where.not(rating: nil)

    if available_driver.length == 0
      return false 
    else
      true
    end

  end
end
