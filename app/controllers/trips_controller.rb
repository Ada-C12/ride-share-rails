class TripsController < ApplicationController

  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    else
      @trips = Trip.all
    end
  end

  def create
    if params[:passenger_id]
      trip_parameters = Trip.create_new_trip
      @trip = Trip.new(
        passenger_id: params[:passenger_id],  
        date: trip_parameters[:date],
        cost: trip_parameters[:cost],
        driver_id: trip_parameters[:driver_id]
      )
      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
        return
      else
        render "new"
        return
      end
    else
      redirect_to trips_path
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
