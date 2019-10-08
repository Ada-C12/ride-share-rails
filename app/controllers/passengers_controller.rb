class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
end
