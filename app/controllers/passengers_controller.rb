class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all 
  end
  
  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil?
      head :not_found
      return
    end
    
    @passenger.destroy
    
    redirect_to root_path
    return
  end
  
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil?
      redirect_to passenger_path
      return
    end
  end
end
