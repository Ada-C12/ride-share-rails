class TripsController < ApplicationController
  
  def index
    # @trips = trips.find_by(passenger_id: params[:passenger_id])
  end
  
  def show
    # @passenger = Passenger.find_by(id: params[:id])
    # if @passenger.nil?
    #   flash[:error] = "Could not find passenger"
    #   redirect_to passengers_path
    #   return
    # end
  end
  
  def new
    # @passenger = Passenger.new
  end
  
  def create
    # @passenger = Passenger.new(passenger_params)
    # if @passenger.save
    #   redirect_to passenger_path(@passenger.id)
    #   return
    # else
    #   render :new
    #   return
    # end
  end
end
