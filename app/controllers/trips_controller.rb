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

  end

  def edit

  end
  
  def update

  end
  
  def destroy

  end
end
