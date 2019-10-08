class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end
  
  def show
    # passenger_id = params[:id]
    # @passenger = Passenger.find_by(id: passenger_id)
    # if @passenger.nil?
    #   head :not_found
    #   return
    # end
    
    #Should this be @passengers? Link: https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/08-rails/using-active-record-in-code.md
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
  end
end
