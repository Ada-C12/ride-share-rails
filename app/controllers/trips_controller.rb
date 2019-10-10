class TripsController < ApplicationController
  
  def create
    trip = Trip.create(
      date: Date.today,
      passenger_id: params[:id],
      driver_id: Driver.find_a_driver,
      cost: 5
    )
    
    if trip.id
      redirect_to root_path
    else
      head :server_error
    end
  end
end
