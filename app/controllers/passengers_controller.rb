class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
    if @passengers.nil?
      head :not_found
      return
    end 
  end 
  
  def show
    passenger_id = params[:id]
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
      redirect_to passengers_path
      return 
    else 
      render :new
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
      head :not_found
      return 
    end 
    if @passenger.update(passenger_params)
      #experiment
      redirect_to passengers_path
      return
    else 
      render :edit
      return
    end 
  end 
  
  def destroy 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil? 
      head :not_found
      return
    end 
    
    @passenger.destroy 
    
    redirect_to passengers_path
    return 
  end 
  
  private 
  
  def passenger_params 
    return params.require(:passenger).permit(:name, :phone_num)
  end 
  
end
