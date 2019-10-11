class TripsController < ApplicationController

  
  def show
    @trip = Trip.find_by(id: params[:id])
  end

  # Creates a new trip
  def create
    driver_id = Trip.find_driver
    date = Date.today

    @trip = Trip.new(passenger_id: params[:passenger_id], rating: nil, cost: 0, date: date, driver_id: driver_id)

    if @trip.save
      redirect_to passenger_path(params[:passenger_id])
    else
      render :new
    end 
  end

  def update
    # @trip = Trip.find_by(id: params[:id])

    # if @trip.update(passenger_id: params[:passenger_id], rating: params[:rating], cost: params[:cost], date: params[:cost], driver_id: params[:driver_id])
    #   redirect_to trip_path
    # end
  end 
end

