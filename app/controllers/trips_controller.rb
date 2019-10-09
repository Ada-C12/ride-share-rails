class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end

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

    if @trip.update(trip_params)
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
