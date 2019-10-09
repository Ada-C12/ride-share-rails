class TripsController < ApplicationController

  def show
    trip_id = params[:id].to_i
    @driver_trips = Trip.find_by(id: driver_id)
    @passenger_trips = Trip.find_by(id: passenger_id)

    if @trip.nil?
      head :not_found
      return 
    end 
  end 

  def new
    @trip = Trip.new
  end 

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else 
      render new_trip_path 
    end 
  end 

  def edit
    @ptrip = Trip.find_by(id: params[:id])
  end 

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.update(trip_params)
      redirect_to trip_path(@trip_id)
    else 
      render new_trip_path
    end 
  end 

  def destroy
    selected_trip = Trip.find_by(id:params[:id])

    if selected_trip.nil?
      redirect_to trip_path
      return
    else 
      selected_trip.destroy
      redirect_to trip_path 
      return
    end 
  end

  
  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end 

end