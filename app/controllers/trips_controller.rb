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
  
  def new
    passenger_id = params[:passenger_id]
    @trip = Trip.new
    if passenger_id.nil?
      @passengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
  end

  def create 
    # will not set params for price, rating. by leaving it blank, it'll default to nil

    @trip = Trip.new( driver_id: driver_id, passenger_id: passenger_id, date: Time.now )

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      
      render new_trip_path
    end
  end

  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :rating, :driver_id, :passenger_id)
  end
end
