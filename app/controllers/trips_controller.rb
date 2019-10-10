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
    @trip = Trip.new
    if passenger_id.nil?
      @pasengers = Passenger.all
    else
      @passengers = [Passenger.find_by(id: passenger_id)]
    end
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
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      # change to root_path once homepage update is merged
      redirect_to trips_path
      return
    end
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
      else
        render :edit
        return
      end
    end
  end

  def delete
    trip = Trip.find_by(id: params[:id])
    if trp.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to root_path
      return
  end

  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
