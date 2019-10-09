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
  
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(passenger_params)
    
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      redirect_to new_passenger_path
    end
  end
  
  private
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
  
end
