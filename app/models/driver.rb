class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def self.total_earnings
  # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
  end 

  def self.available
    return Task.where(status: "available")
  end 

  def self.busy
    return Driver.where(status: "busy")
  end 
  # When a user deletes a driver associated with a trip, it is up to you and your team on how to deal with "validations"/consequences surrounding the deleted driver and the associated trip
end
