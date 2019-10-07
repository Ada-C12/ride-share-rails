class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    
  end

  def new
  end

  def edit
  end
end
