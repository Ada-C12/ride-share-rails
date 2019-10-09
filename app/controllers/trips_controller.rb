class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
  end
  
  def new 
    # coming from Passengers/:id, clicking request trip button
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = Trip.new(date: Time.now, passenger_id:@passenger.id)
    redirect_to action: "create"
    raise
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
<<<<<<< HEAD
    @trip = Trip.new(trip_params)
=======
    @trip = Trip.new(date: Time.now, passenger_id:@passenger.id)
    raise
    @trip = Trip.new(trip_request_params)
>>>>>>> 9daa6d555a25551d09c2a655065a379f889c34b9
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
  
  def trip_request_params
    return params.require(:trip).permit(:date, :passenger_id)
  end
end
