class PassengersController < ApplicationController
  
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    else
      @passengers = Passenger.all
    end
  end 
  
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
  end
  
  def new 
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(name: params[:passenger][:name], phone_num: params[:passenger][:phone_num])
    if @passenger.save 
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :new
      return 
    end
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to driver_path
      return
    end
  end
  
  def update 
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.update(name: params[:passenger][:name], phone_num: params[:passenger][:phone_num])
      redirect_to passenger_path
      return
    else
      render :edit
      return
    end
  end
  
  def completed
  end
  
  def destroy 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    @passenger.destroy 
    redirect_to passengers_path
  end
end
