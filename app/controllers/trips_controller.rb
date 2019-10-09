class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
  end
  
  def new
    @trip = Trip.new()
  end
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end 

  def new
    @trip = Trip.new
  end 

  def create
    @driver = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
    else
      redirect_to nope_path
    end
  end

  def edit
    @trip = Trip.find_by(id:params[:id])

    if @trip.nil?
      redirect_to root_path
      return
    end
  end 

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      redirect_to nope_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to nope_path
    end
  end 

  def destroy
    selected_trip = Trip.find_by(id: params[:id])

    if selected_trip.nil?
      redirect_to root_path
      return
    else
      selected_triip.destroy
      redirect_to trip_path
      return
    end
  end 

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
