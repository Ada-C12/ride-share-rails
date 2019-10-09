class TripsController < ApplicationController
  
  def index
    passenger_id = params[:passenger_id]
    driver_id = params[:driver_id]
    if passenger_id.nil? && driver_id.nil?
      @trips = Trip.all_trips
    elsif passenger_id
      @passenger = Passenger.find_by(id: passenger_id)
      if @passenger
        @trips = @passenger.trips
      end
    elsif driver_id
      @driver = Driver.find_by(id: driver_id)
      if @driver
        @trips = @driver.trips
      end
    else
      head :not_found
      return
    end
  end
  
  def show
    @trip = Trip.find_by(passenger_id: params[:passenger_id])
    if @trip.nil?
      flash[:error] = "Could not find trip"
      redirect_to trips_path, status: :not_found
      return
    end
  end
  
  def new
    @trip = Trip.new
  end
  
  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      render :new
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
  
end
