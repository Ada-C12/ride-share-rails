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
    passenger_id = params[:passenger_id]
    @passenger = Passenger.find_by(id: passenger_id)

    # get trip_params from Passenger.request_trip (making fake trips!)
    request_trip_params = @passenger.request_trip_params

    @trip = Trip.create(request_trip_params)
    @trip.passenger = @passenger
    @trip.save

    if @trip.id?
      @trip.driver.toggle_active
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(@passenger.id)
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end

  def create_trip_params
    return
  end
  
end
