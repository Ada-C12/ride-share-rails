class TripsController < ApplicationController
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
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
    else
      render new_trip_path
    end
  end
  
  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :driver_id, :passenger_id, :rating)
  end
  
  
end
