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
    driver_id = Driver.find_by(active: false).id

    head :not_found if driver_id.nil?

    @trip = Trip.new(date: Date.today, rating: nil, cost: 13.00, driver_id: driver_id, passenger_id: params[:passenger_id])
    
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to passenger_path(@trip.passenger_id)
      return
    end
  end

  def edit

  end
  
  def update

  end
  
  def destroy

  end

  # private

  # def trip_params
  #   return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  # end
end
