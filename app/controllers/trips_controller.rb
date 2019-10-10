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
    @trip = Trip.new(trip_params) #instantiate a new book
    if @trip.save # save returns true if the database insert succeeds
      redirect_to passenger_path(trip_params.passenger_id) # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new book form view again
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:trip_id, :date, :passenger_id, :driver_id, :price, :rating)
  end
end
