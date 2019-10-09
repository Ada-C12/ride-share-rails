class TripsController < ApplicationController
 
 def show
  @trip = Trip.find_by(id: params[:id])
  
  head :not_found if @trip.nil?
 end
 
end
