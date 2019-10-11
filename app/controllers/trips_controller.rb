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
    first_available_driver = Driver.find_by(active: false)
    passenger_id = params[:trip][:passenger_id]

    @trip = Trip.new(
      date: Date.today,
      rating: nil,
      cost: rand(165..4000),
      passenger_id: passenger_id,
      driver_id: first_available_driver.id
    )

    if @trip.save
      first_available_driver.toggle_active
      redirect_to passenger_path(passenger_id)
      return
    else
      redirect_to root_path
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    else
      driver_id = params[:driver_id]
      passenger_id = params[:passenger_id]

      if driver_id.nil?
        @drivers = Driver.all
      else
        @drivers = [Driver.find_by(id: driver_id)]
      end

      if passenger_id.nil?
        @passengers = Passenger.all
      else
        @passengers = [Passenger.find_by(id: passenger_id)]
      end
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return
    else
      driver_id = params[:driver_id]
      passenger_id = params[:passenger_id]

      if @trip.update(trip_params)
        redirect_to trip_path(@trip.id)
        return
      else
        if driver_id.nil?
          @drivers = Driver.all
        else
          @drivers = [Driver.find_by(id: driver_id)]
        end
  
        if passenger_id.nil?
          @passengers = Passenger.all
        else
          @passengers = [Passenger.find_by(id: passenger_id)]
        end
        
        render :edit
        return
      end
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    if trip.nil?
      head :not_found
      return
    else
      trip.destroy
      redirect_to root_path
      return
    end
  end

  private
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :passenger_id, :driver_id)
  end
end
