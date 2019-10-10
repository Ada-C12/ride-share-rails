class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def total_earnings
  # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  end 

  def self.available
    first_available =  Driver.where(status: nil).first
    first_available.busy 
    return first_available 
  end 

  def busy
    self.update(status: true)
  end 
  # When a user deletes a driver associated with a trip, it is up to you and your team on how to deal with "validations"/consequences surrounding the deleted driver and the associated trip
end
