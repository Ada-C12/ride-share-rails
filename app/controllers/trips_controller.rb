class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id:trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end
  
  # def new
  #   @passenger = Passenger.find_by(id: params[:passenger_id])
  #   @trip = Trip.new(passenger_id: @passenger.id)
  # end
  
  def create
    @trip = Trip.new(passenger_id: params[:id])
    driver = Driver.where(:active => false).first
    @trip.date = Date.today
    @trip.cost = rand(1000..3000).to_f
    @trip.rating = nil
    @trip.driver_id = driver.id
    if @trip.save
      redirect_to passenger_trips_path(@trip.passenger.id)
      driver.update(active: true)
    else
      new_passenger_trip_path(id: trip_params[:passenger_id])
      
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    if !@trip
      redirect_to trips_path
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    if !@trip
      redirect_to trips_path
      return
    end
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
    else
      render new_trip_path
    end
  end
  
  def destroy
    trip_to_delete = Trip.find_by(id: params[:id])
    if trip_to_delete.nil?
      redirect_to trips_path
      return
    else
      trip_to_delete.destroy
      redirect_to trips_path
      return
    end
  end

  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :cost, :rating)
  end
end
