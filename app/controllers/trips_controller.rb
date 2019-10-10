class TripsController < ApplicationController
 
 def show
  @trip = Trip.find_by(id: params[:id])
  
  head :not_found if @trip.nil?
 end

 def create
   driver = Driver.find_by(active: nil)
   trip = Trip.create(date: Date.today,
                      cost: rand(500..50_000),
                      passenger_id: params[:passenger_id],
                      driver_id: driver.id)
   if trip
     redirect_to trip_path(trip.id)
   else
     redirect_to passenger_path(params[:passenger_id])
   end
 end
end
