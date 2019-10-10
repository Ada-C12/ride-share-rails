class TripsController < ApplicationController
  def index
    @trips = Trip.all
    if @trips.nil?
      head :not_found
      return
    end 
  end 
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil? 
      head :not_found
      return
    end 
  end 
  
  def create 
    if params[:passenger_id]
      custom_params = {
      trip: {
      passenger_id: Passenger.find_by(id: params[:passenger_id]),
      driver_id: Driver.find_available,
      date: Time.now,
      rating: nil,
      cost: rand(1...5000),
    }
  }
  @trip = Trip.new(custom_params)
else 
  @trip = Trip.new(trip_params)
  if @trip.save 
    redirect_to trips_path
    return 
  else 
    render :new
    return
  end 
end 

def edit
  @trip = Trip.find_by(id: params[:id])
  if @trip.nil? 
    head :not_found
    return
  end 
end 

def update 
  @trip = Trip.find_by(id: params[:id])
  if @trip.update(trip_params)
    #experiment
    redirect_to trips_path
    return
  else 
    render :edit
    return
  end 
end 

def destroy 
  trip_id = params[:id]
  @trip = Trip.find_by(id: trip_id)
  
  if @trip.nil? 
    head :not_found
    return
  end 
  
  @trip.destroy 
  redirect_to trips_path
  return 
end 

private 

def trip_params 
  return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
end 

end

end
