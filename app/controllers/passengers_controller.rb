class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(get_params)
    puts @passenger
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  
  private
  def get_params
    return params.require[:passenger].permit[:name, :phone_num]
  end
end
