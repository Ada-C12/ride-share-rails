class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
  end
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def new
    if params[:passenger_id]
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = @passenger.trips.new
    end
    @trip = Trip.new
  end
  
  def create 
    @trip = Trip.new( trip_params )
    if @trip.date.nil?
      @trip.date = Date.today
    end
    if @trip.cost.nil?
      @trip.cost = 0
    end
    
    @drivers = Driver.where(active: false)
    @trip.driver_id = @drivers[rand(0...@drivers.length)].id
    
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to root_path
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id] )
  end
  
  def update
    @trip = Trip.find_by(id: params[:id] )
    if @trip.update( trip_params )
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit
    end
  end
  
  def destroy
    trip = Trip.find_by( id: params[:id] )
    if trip.nil?
      redirect_to trips_path
      return
    else
      trip.destroy
      redirect_to trips_path
      return
    end
  end
  
  
  private
  
  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :date, :rating, :cost)
    
  end
  
  
end
