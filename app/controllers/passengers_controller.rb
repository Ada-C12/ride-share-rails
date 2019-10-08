class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end
  
  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      head :not_found
      return
    end
  end
  
end
