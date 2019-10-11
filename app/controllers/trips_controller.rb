class TripsController < ApplicationController
  
  def index
    passenger_id = params[:passenger_id]
    driver_id = params[:driver_id]
    if passenger_id.nil? && driver_id.nil?
      @trips = Trip.all_trips
    elsif passenger_id
      @passenger = Passenger.find_by(id: passenger_id)
      if @passenger
        @trips = @passenger.trips
      end
    elsif driver_id
      @driver = Driver.find_by(id: driver_id)
      if @driver
        @trips = @driver.trips
      end
    else
      head :not_found
      return
    end
  end
  
  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      flash[:error] = "Could not find trip"
      redirect_to trips_path, status: :not_found
      return
    end
  end
  
  def new
    @date = Date.today
    @cost = rand(1000..3000)
    @driver = Driver.available_driver.id
    @trip = Trip.new
    passenger_id = params[:passenger_id]
    if passenger_id.nil?
      @passengers = Passenger.all 
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
    
  end
  
  def create
    passenger_id = params[:trip][:passenger_id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    @trip = @passenger.trips.create(trip_params)   
    
    if @trip.id?
      @trip.driver.toggle_active
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(@passenger.id)
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      flash[:error] = "Could not find trip"
      redirect_to trips_path
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      flash[:error] = "Could not find trip"
      redirect_to trips_path
      return
    end
    
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      flash[:error] = "Could not find trip"
      redirect_to passengers_path
      return
    end
    
    if @trip.destroy
      redirect_to trips_path
      return
    else
      redirect_to trip_path
      return
    end
  end
  
  
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
  
end
