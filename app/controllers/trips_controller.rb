class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    trip_params = passenger.request_a_ride
    @trip = Trip.new(trip_params)
    
    if @trip.save
      driver = Driver.find_by(id: trip_params[:driver_id])
      driver.go_offline
      redirect_to trip_path(@trip.id)
      return
    else
      render new_trip_path
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    trip = Trip.find_by(id: params[:id])
    if trip.update(trip_edit_params)
      trip.passenger.complete_trip(trip.id)
      redirect_to trip_path(trip.id)
      return
    else
      redirect_to root_path
      return
    end
  end
  
  def destroy
    found_trip = Trip.find_by(id: params[:id])
    if found_trip.nil?
      redirect_to root_path
      return
    else
      found_trip.destroy
      found_trip.driver.go_online
      redirect_to root_path
      return
    end
  end
  
  
  
  private
  
  def trip_edit_params
    return params.require(:trip).permit(:cost, :rating)
  end
  
end
