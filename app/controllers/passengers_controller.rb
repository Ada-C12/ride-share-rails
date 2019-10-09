class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params) rescue nil
    if @passenger
      successful = @passenger.save
      if successful
        redirect_to passenger_path(@passenger.id)
        return
      end
    end

    redirect_to new_passenger_path
    return
  end

  private 

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num) 
  end
end
