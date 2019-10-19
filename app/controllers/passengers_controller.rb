class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_passenger_path
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if !@passenger
      redirect_to passengers_path
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if !@passenger
      redirect_to passengers_path
      return
    end
    @passenger.name = params[:passenger][:name]
    @passenger.phone_num = params[:passenger][:phone_num]

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_passenger_path
    end
  end

  def destroy
    passenger_to_delete = Passenger.find_by(id: params[:id])
    if passenger_to_delete.nil?
      redirect_to passengers_path
      return
    else
      passenger_to_delete.destroy
      redirect_to passengers_path
      return
    end
  end

  def rate_trip
    trip_to_rate = Trip.find_by(id: params[:trip_id])
    trip_to_rate.rating = params[:rating]
    trip_to_rate.save
    trip_to_rate.driver.update(active: false)

    redirect_to passenger_trips_path(trip_to_rate.passenger_id)
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
