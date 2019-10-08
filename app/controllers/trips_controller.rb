class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def edit
  end
  
  def update
    #Handle Validation Errors
  end
  
  def new
  end
  
  def create
    #Handle Validation Errors
  end
end
