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
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      head :not_found
      return
    end
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to passenger_path 
      return
    end
    
    if @passenger.update(
      name: params[:passenger][:name], 
      phone_number: params[:passenger][:phone_number])
      redirect_to passenger_path  
      return
    else  
      render :edit  
      return
    end
  end
  
end
