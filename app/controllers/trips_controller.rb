class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    trip_id = params[:id]
    @trip = trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def new
    @trip = trip.new
  end

  def create
    @trip = trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      render new_trip_path
    end
  end

  def edit
    @trip = trip.find_by(id: params[:id])
    if @trip == nil
      redirect_to trip_path
    end
  end

  def update
    @trip = trip.find_by(id: params[:id])

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
    the_correct_trip = trip.find_by( id: params[:id] )

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
    #only added date, rating, and cost as params because the other params are foreign keys
    return params.require(:trip).permit(:date, :rating, :cost)
  end

end
