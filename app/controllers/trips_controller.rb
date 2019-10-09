class TripsController < ApplicationController
  
  def index
    driver_id = params[:driver_id]
    passenger_id = params[passenger_id]
    
    if driver_id.nil? && passenger_id.nil?
      @trips = Trip.all
    elsif driver_id.nil?
      @passenger = Passenger.find_by(id: passenger_id)
      if @passenger
        @trips = @passenger.trips
      else
        head :not_found
      end
    else
      @driver = Driver.find_by(id: driver_id)
      if @driver
        @trips = @driver.trips
      else
        head :not_found
      end
    end
  end
  
end
