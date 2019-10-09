class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      head :not_found
      return
    end
  end

  def create
    # passenger should be set to id of passenger from new_passenger_trip
    # rating should default to nil (update schema)
    # cost should be randomly assigned (default value?)
    # dirver_id should be assigned from random driver
    # set up form to send this data?

    # This is failing. How do we bring in the passenger id?
    passenger_id = params[:id]

    @trip = Trip.new(trip_params) rescue nil
    if @trip
      successful = @trip.save
      if successful
        redirect_to passenger_path(@trip.passenger.id)
        return
      end
    end

    redirect_to new_passenger_trip_path(passenger_id)
    return
  end

  # def edit

  # end

  # def update

  # end

  # def destroy

  # end

  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
