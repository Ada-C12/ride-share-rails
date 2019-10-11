class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    head :not_found if @passenger.nil?
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.create(passenger_params)
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_passenger_path
    end
  end
  
  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    return head :not_found unless @passenger
    update_trips
    @passenger.destroy
    redirect_to root_path
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    return redirect_to passengers_path unless @passenger
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    return head :not_found unless @passenger
    
    if @passenger.update(passenger_params)
      redirect_to passengers_path
    else
      render "edit"
    end
  end
  
  def update_trips
    @trips = Trip.where(passenger_id: @passenger.id)
    @trips.each do |trip|
      trip.passenger_id = 301
      trip.save
    end
  end
  
  
  private
  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
    
  end
end