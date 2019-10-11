require 'pry'

class TripsController < ApplicationController
  
  def index
    driver_id = params[:driver_id]
    passenger_id = params[:passenger_id]
    
    if driver_id.nil? && passenger_id.nil?
      @trips = Trip.all
    elsif driver_id.nil?
      @passenger = Passenger.find_by(id: passenger_id)
      if @passenger
        @trips = @passenger.trips
      else
        head :not_found
      end
    else
      @driver = Driver.find_by(id: driver_id)
      if @driver
        @trips = @driver.trips
      else
        head :not_found
      end
    end
  end
  
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end
  
  def new
    passenger_id = params[:passenger_id]
    
    @trip = Trip.new
    
    if passenger_id.nil?
      @passengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
    
    # @drivers = Driver.all
    @drivers = Driver.where(active: nil)
  end
  
  def create 
    new_passenger_id = params[:trip][:passenger_id]
    new_driver_id = params[:trip][:driver_id]
    
    @trip = Trip.new( passenger_id: new_passenger_id,driver_id: new_driver_id)
    
    if @trip.save
      @trip.driver.active = true
      @trip.driver.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passengers_path
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to trips_path
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    else
      @trip.update(rating: params[:trip][:rating] )
      @trip.driver.active = nil
      @trip.driver.save
      redirect_to trip_path(@trip.id)
      return
    end
  end
  
  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :rating, :driver_id, :passenger_id)
  end
end
