class TripsController < ApplicationController
  
  def index
    @passenger = Passenger.find_by(id: params[:passenger_id])
    if @passenger.nil?
      # just showing all Trips table for all passengers
      @trips = Trip.all
    else
      # showing trips for a specific passenger
      @trips = Trip.where(passenger_id: @passenger.id)
    end
  end
  
  def new 
    redirect_to nope_path(params: {msg: "Not supposed to be here, all trip requests from a specific passenger goes straight to trip#create!"})
  end
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end 
  
  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      x= "hahaha"
      redirect_to trip_path(@trip.id)
      raise
    else
      x = "wtf"
      redirect_to nope_path
      raise
    end
  end
  
  def edit
    @trip = Trip.find_by(id:params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end
  end 
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to nope_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to nope_path
    end
  end 
  
  def destroy
    selected_trip = Trip.find_by(id: params[:id])
    
    if selected_trip.nil?
      redirect_to root_path
      return
    else
      selected_triip.destroy
      redirect_to trip_path
      return
    end
  end 
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
  
end
