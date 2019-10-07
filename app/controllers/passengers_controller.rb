class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def create
    @passenger = Passenger.new( strongs_params )
    @passenger.save
  end
  
  
  private
  
  def strongs_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
