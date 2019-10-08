class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def create
    if params[:driver_id] && params[:passenger_id]
      @trip = Trip.new(trip_params)
      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
        return
      else
        render "new"
        return
      end
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
