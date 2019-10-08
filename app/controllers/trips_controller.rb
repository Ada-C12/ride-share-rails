class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
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
      return
    else
      render new_trip_path
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
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to root_path
      return
    end
  end

  def destroy
    found_trip = Trip.find_by(id: params[:id])
    if found_trip.nil?
      redirect_to root_path
      return
    else
      found_trip.destroy
      redirect_to root_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:passenger_id, :driver_id, :date)
  end
end
