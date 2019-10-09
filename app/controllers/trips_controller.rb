class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
    @drivers = Driver.all
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
    @trip = Trip.new
  end
  
  def create 
    @trip = Trip.new( trip_params )
    if @trip.date == nil
      @trip.date = Date.today
    end
    if @trip.cost == nil
      @trip.cost = 0
    end
    @trip.rating = 0
    @trip.driver_id = @drivers[rand(0...@drivers.length)].id
    @trip.save
  end
  
  
  private
  
  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :date => Date.today, :rating => 0, :cost => 0)
    
  end
  
  
end
