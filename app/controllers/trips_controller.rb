class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      flash[:error] = "Could not find trip ID #{ params[:id] }"
      redirect_to trips_path
      return
    end 
  end
  
  def new
    if params[:id]
      passenger = Passenger.find_by(passenger_id: passenger.id)
      @trip = passenger.trips.new
    else
      @trip = Trip.new
    end 
  end
  
  def create
    if params[:passenger_id]
      trip_parameter = Trip.new_trip
      @trip = Trip.new(
        passenger_id: params[:passenger_id],
        driver_id: trip_parameter[:driver].id,
        date: trip_parameter[:date],
        cost: trip_parameter[:cost]
      )
      
      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
        return
      else
        render :new
        return
      end
    else
      redirect_to trips_path
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      flash[:error] = "Could not find trip ID #{ @trip.id }"
      redirect_to trips_path
      return
    end 
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      flash[:error] = "Could not find trip ID #{ @trip.id }"
      redirect_to trips_path
      return
    end 
    
    @trip.destroy
    redirect_to trips_path
    return
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :trip_id, :driver_id)
  end
  
end
