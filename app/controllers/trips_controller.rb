class TripsController < ApplicationController
  # def index
  #   # if params[:driver_id]
  #   #   @driver = Driver.find_by(id: driver_id)
  #   #   if @driver
  #   #     @trips = @driver.trips
  #   #   else
  #   #     head :not_found
  #   #     return
  #   #   end
  #   # elsif param[:passenger_id]
  #   #   @passenger = Passenger.find_by(id: passenger_id)
  #   #   if @passenger
  #   #     @trips = @passenger.trips
  #   #   else
  #   #     head :not_found
  #   #     return
  #   #   end
  #   # else
  #   #   @trips = Trip.all
  #   # end
  # end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def new
    @passenger = Passenger.find_by(id: param[:passenger_id])
    # @driver = Driver.first
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
    @trip = Trip.find_by(id: params[:id])
    if @trip == nil
      redirect_to trip_path
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip == nil
      redirect_to trips_path
      return
    end

    @trip.name = params[:trip][:name]
    @trip.phone_num = params[:trip][:phone_num]

    if @trip.save
      redirect_to trip_path(@trip.id)
    end
  end

  def destroy
    the_correct_trip = Trip.find_by( id: params[:id] )

    if the_correct_trip.nil?
      redirect_to trips_path
      return
    else
      the_correct_trip.destroy
      redirect_to root_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end

end
