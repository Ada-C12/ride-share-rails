class Driver < ApplicationRecord
  has_many :trips

  def trips
    driver_id = params[:id]
    driver_trips = Trip.where(driver_id: driver_id)
    return driver_trips
  end 
end
