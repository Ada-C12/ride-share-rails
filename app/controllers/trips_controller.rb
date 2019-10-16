class TripsController < ApplicationController
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id) 
  end
  
  def create
    driver = Trip.find_driver
    date = Date.today
    @trip = Trip.new(passenger_id: params[:passenger_id], rating: nil, cost: 1, date: date, driver_id: driver.id)
    
    if @trip.save 
      driver.status = "unavailable"
      driver.save
      redirect_to passenger_path(params[:passenger_id])
    else
      render :new
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil? 
      redirect_to passengers_path
    end
    
  end
  
  def update 
    driver_id = Trip.find_driver
    date = Date.today
    
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.update(trip_params)
      redirect_to passenger_path(@trip.passenger_id)
      return
    else
      
      render :show
      return
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.destroy()
      redirect_to root_path
    end
    
    
  end
  private 
  
  def trip_params
    return params.require(:trip).permit(:rating, :cost, :driver_id, :passenger_id, :date)
  end
  
end
