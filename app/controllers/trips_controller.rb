class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def create
    if params[:passenger_id]
      trip_parameters = Trip.create_new_trip
      @trip = Trip.new(
        passenger_id: params[:passenger_id],
        date: trip_parameters[:date],
        cost: trip_parameters[:cost],
        driver_id: trip_parameters[:driver_id],
      )
      if @trip.save
        redirect_to passenger_path(params[:passenger_id])
        return
      else
        render "new"
        return
      end
    else
      redirect_to trips_path
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end

    @trip.update(trip_params)

    redirect_to passenger_path(@trip.passenger.id)
    return
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to passengers_path
      return
    end

    @trip.destroy
    redirect_to passengers_path
    return
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
