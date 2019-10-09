class TripsController < ApplicationController
  def index
    @trips = Trip.all
    @drivers = Driver.all
    @passengers = Passenger.all
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
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def update
    #Handle Validation Errors
    
    @trip = Trip.find_by(id: params[:id])
    if @trip.update(trip_params)
      redirect_to trips_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :edit # show the new book form view again
      return
    end
  end
  
  def new
  end
  
  def create
    #Handle Validation Errors
  end
end
