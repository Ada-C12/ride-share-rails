class TripsController < ApplicationController
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    print "*#*#*#*#*#  passengers is #{@passengers}" 
    if @trip.nil?
      head :not_found
      return 
    end 
  end 
  
  def new
    passenger_id = params[:passenger_id]
    @trip = Trip.new(passenger_id: passenger_id) 
    if passenger_id.nil?
      @passengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end 
  end
  
  def create
    @trip = Trip.new(trip_params)
    
    if @trip.save
      redirect_to passenger_path(@passenger.id)
    else 
      redirect_to new_passenger_trip_path(@trip.passenger_id)
    end 
  end 
  
  def edit
    @trip = Trip.find_by(id: params[:id])
  end 
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.update(trip_params)
      redirect_to trip_path(@trip_id)
    else 
      render new_trip_path
    end 
  end 
  
  def destroy
    selected_trip = Trip.find_by(id:params[:id])
    
    if selected_trip.nil?
      redirect_to trip_path
      return
    else 
      selected_trip.destroy
      redirect_to trip_path 
      return
    end 
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :date, :rating, :cost)
  end 
  
end