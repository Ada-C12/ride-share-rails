class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end
  
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
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
    
    @passenger = Passenger.new(passenger_params) #instantiate a new passenger
    if @passenger.save # save returns true if the database insert succeeds
      redirect_to passengers_path # go to the index so we can see the passenger in the list
      return
    else # save failed :(
      render :new # show the new book form view again
      return
    end
  end
end
