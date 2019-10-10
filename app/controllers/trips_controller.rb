class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def create
    driver = Driver.find_by(active: false)

    if driver.nil?
      head :not_found 
      return
    end

    @trip = Trip.new(date: Date.today, rating: nil, cost: 13.00, driver_id: driver.id, passenger_id: params[:passenger_id])
    
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(@trip.passenger_id)
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render edit_trip_path
      return
    end
  end
  
  def destroy
    selected_trip = Trip.find_by(id: params[:id])
    trip_passenger = selected_trip.passenger

    if selected_trip.nil?
      redirect_to passenger_path(trip_passenger.id)
      return
    else
      selected_trip.destroy
      redirect_to passenger_path(trip_passenger.id)
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
