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
      redirect_to passenger_path(@trip.passenger_id) # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :edit # show the new book form view again
      return
    end
  end
  
  def new
    if params[:passenger_id]
      # This is the nested route, /author/:author_id/books/new
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
      
    else
      # This is the 'regular' route, /books/new
      @trip = Trip.new
    end
  end
  
  def create
    #Handle Validation Errors
    generated_trips_params = {
      date: Time.now, 
      passenger_id: params[:passenger_id], 
      driver_id: 1,
      cost: rand(4..99)
    }
    @trip = Trip.new(generated_trips_params) #instantiate a new book
    
    if @trip.save # save returns true if the database insert succeeds
      redirect_to passenger_path(params[:passenger_id]) # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new book form view again
      return
    end
  end
  
  def destroy
    # Arrange
    # Ensure there is an existing driver saved
    new_trip = Trip.create(date: Time.now, passenger_id: "4", driver_id: "5", cost: 8)
    # Act-Assert
    #Ensure that there is a change of -1 in Driver.count
    expect {delete trip_path(new_trip.id)}.must_differ 'Trip.count', -1
    # Assert
    # Check that the controller redirects
    must_respond_with :redirect
    must_redirect_to trips_path
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:trip_id, :date, :passenger_id, :driver_id, :cost, :rating)
  end
end
