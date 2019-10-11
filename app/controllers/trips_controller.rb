class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end
  
  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    driver = passenger.find_driver
    
    if driver.nil?
      head :not_found 
      return
    end
    
    @trip = Trip.new(date: Date.today, rating: nil, cost: rand(500..5000), driver_id: driver.id, passenger_id: passenger.id)
    
    if @trip.save
      @trip.driver.active
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(@trip.passenger_id)
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else      
      render :edit
      return
    end
  end
  
  def destroy
    selected_trip = Trip.find_by(id: params[:id])
    
    if selected_trip.nil?
      head :not_found
      return
    else
      selected_trip.destroy
      redirect_to passenger_path(selected_trip.passenger.id)
      return
    end
  end
  
  def complete_trip
    @trip = Trip.find_by(id: params[:id])
    
    unless @trip.driver
      @trip.driver.inactive
      redirect_to trip_path(@trip.id)
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
