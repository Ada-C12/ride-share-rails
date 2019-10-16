class TripsController < ApplicationController
  
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    else
      @trips = Trip.all
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
    passenger = Passenger.find_by(id: params[:passenger_id])
    # if passenger doesnt exist
    # @drivers = Driver.all
    driver = Driver.assign_driver
    
    trip_hash = {
      passenger_id: passenger.id,
      driver_id: driver.id,
      date: Date.current,
      rating: nil,
      cost: 0
    }
    @trip = Trip.new(trip_hash)
    
    if @trip.save
      driver.available = false
      driver.save
      redirect_to passenger_path(id: params[:passenger_id] )
      return
    else
      render :new
    end
    
    
  end
  
  # def new
  #   if params[:passnger_id]
  #     passenger = Passenger.find_by(id: params[:passenger_id])
  #     driver_id = #model method that chooses driver that is available
  
  #     @trip = passenger.trips.new()
  
  #     redirect_to passenger_path
  #     return
  #   else
  #     @trip = Trip.new
  #   end
  # end
  
  def edit
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def update
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    end
    
    if @trip.update(trip_params)
      @trip.driver.available = true
      @trip.driver.save
      redirect_to trip_path
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
