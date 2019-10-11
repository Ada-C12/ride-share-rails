class TripsController < ApplicationController
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return 
    end 
  end 
  
  def new
    passenger_id = params[:passenger_id]
    @trip = Trip.new(passenger_id: passenger_id) 
    
    # If we are going through /passengers/2/trips/new, then it is for the route /passengers/:passenger_id/trips/new
    if Passenger.find_by(id: passenger_id).nil?
      redirect_to passengers_path
      # Instead of raise, maybe do something like redirect_to
    end
    
    if passenger_id.nil?
      @passengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end 
  end
  
  def create
    passenger = Passenger.find_by(id:params[:passenger_id])
    trip_params = passenger.request_trip
    @trip = Trip.create(trip_params)
    
    # @trip.passenger = (Passenger_params)
    # @tripdriver = (Driver_params)
    
    if @trip
      redirect_to trip_path(@trip.id), notice: 'Trip was successfully created.'
    else 
      render new_trip_path
    end 
  end 
  
  def edit
    @trip = Trip.find_by(id: params[:id])
  end 
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
    else 
      render new_trip_path
    end 
  end 
  
  def destroy
    selected_trip = Trip.find_by(id:params[:id])
    selected_passenger = selected_trip.passenger_id
    passenger = Passenger.find_by(id:params[:passenger_id])
    if selected_trip.nil?
      redirect_to trip_path
      return
    else 
      selected_trip.destroy
      redirect_to passenger_path(id:selected_passenger)
      return
    end 
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :date, :rating, :cost)
  end 
  
end