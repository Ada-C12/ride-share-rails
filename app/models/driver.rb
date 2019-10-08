class Driver < ApplicationRecord
  has_many :trips
  validates :name, :vin, presence: true
  
  def find_driver_trips
    return self.trips.all
    # driver_trips = self.trips.where({id: driver_id})
    # return driver_trips
    
  end
  
  
end
