class TripsController < ApplicationController
  def index
    # if params[:driver_id]
    #   @driver = Driver.find_by(id: driver_id)
    #   if @driver
    #     @trips = @driver.trips
    #   else
    #     head :not_found
    #     return
    #   end
    # elsif param[:passenger_id]
    #   @passenger = Passenger.find_by(id: passenger_id)
    #   if @passenger
    #     @trips = @passenger.trips
    #   else
    #     head :not_found
    #     return
    #   end
    # else
    #   @trips = Trip.all
    # end
  end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
    end
  end

  def create
    trip_cost = rand(100...10000) #random cost between $1 and $100 generated
    driver_chosen = Driver.find_by(available: true)

    if driver_chosen == nil
      redirect_to new_trip_path
    end

    driver_chosen.go_offline

    @passenger = Passenger.find_by(id: params[:passenger_id])
    @trip = Trip.new(passenger_id: params[:passenger_id], driver_id: driver_chosen.id, date: Date.today, cost: trip_cost)

    # @trip = @passenger.trips.new(driver_id: driver_chosen.id, date: Date.today, cost: trip_cost)

    if @trip.save
      redirect_to passenger_path(@passenger.id)
    else
      render new_trip_path
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    unless @trip
      redirect_to trips_path
    end
  end

  def update

    @trip = Trip.find_by(id: params[:id])

    unless @trip
      head :not_found
      return
    end

    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit, status: :bad_request
    end

  end


  def destroy
    trip_to_delete = Trip.find_by(id: params[:id])

    unless trip_to_delete
      head :not_found
      return
    end

    trip_to_delete.destroy
    redirect_to root_path
    #how to redirect to same drivers page? this redirects to list of drivers
  end
  
  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
