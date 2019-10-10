class TripsController < ApplicationController
  def index
    passenger_id = params[:passenger_id]
    driver_id = params[:driver_id]

    if passenger_id
      @passenger = Passenger.find_by(id: passenger_id)
      if @passenger
        @trips = @passenger.trips
        return
      else
        head :not_found
        return
      end
    elsif driver_id
      @driver = Driver.find_by(id: driver_id)
      if @driver
        @trips = @driver.trips
        return
      else
        head :not_found
        return
      end
    else
      @trips = Trip.all
      return
    end
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def new
    passenger_id = params[:passenger_id]
    @trip = Trip.new
    if passenger_id.nil?
      @pasengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      render new_trip_path
    end
  end

  # def edit

  # end

  # def update

  # end

  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
