class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def new
    passenger_id = params[:passenger_id]
    @passenger = Passenger.find_by(id: passenger_id)
    @trip = Trip.new(@passenger.request_trip[:trip])
    if passenger_id.nil?
      @pasengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
  end
  
  def create
    passenger_id = trip_params[:passenger_id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger
      passenger = Passenger.find_by(id: trip_params[:passenger_id])
      @trip = Trip.new(trip_params)
      
      if @trip.save
        @trip.driver.toggle_active
        redirect_to passenger_path(@trip.passenger_id)
        return
      else
        driver_id = params[:driver_id]
        passenger_id = params[:passenger_id]
        @drivers = driver_id.nil? ? Driver.all : [Driver.find_by(id: driver_id)]
        @passengers = passenger_id.nil? ? Passenger.all : [Passenger.find_by(id: passenger_id)]  
          
        render :new
        return
      end
    end
    
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end
    
    driver_id = params[:driver_id]
    passenger_id = params[:passenger_id]
    
    @drivers = driver_id.nil? ? Driver.all : [Driver.find_by(id: driver_id)]  
    @passengers = passenger_id.nil? ? Passenger.all : [Passenger.find_by(id: passenger_id)]  
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    else
      if @trip.update(trip_params)
        redirect_to trip_path(@trip.id)
        return
      end
      
      driver_id = params[:driver_id]
      passenger_id = params[:passenger_id]
      @drivers = driver_id.nil? ? Driver.all : [Driver.find_by(id: driver_id)]
      @passengers = passenger_id.nil? ? Passenger.all : [Passenger.find_by(id: passenger_id)]  
      
      render :edit
      return   
    end
  end
  
  def destroy
    trip = Trip.find_by(id: params[:id])
    if trip.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to root_path
      return
    end
  end
  
  def complete
    @trip = Trip.find_by(id: params[:id])
    if @trip
      passenger = @trip.passenger
      if passenger.complete_trip(@trip)
        redirect_to trip_path(Trip.find_by(id: @trip.id))
        return
      end
    end
  end
  
  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
