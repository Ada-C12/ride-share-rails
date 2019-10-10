class TripsController < ApplicationController
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def new
      @trips = Trip.new
  end
  
  def create  
    if params[:passenger_id]
      default_trip_details = {
        passenger_id: params[:passenger_id],
        driver_id: 1,
        date: Date.current,
        cost: rand(1..1000)
      }

      @trip = Trip.new(default_trip_details)
    else
      @trip = Trip.new(trip_params)
    end

    if @trip.save
    else
      redirect_to root_path
      return
    end
    
    if @trip.driver.update({active: true})
      redirect_to trip_path(@trip.id)
      return
    else
      raise ArgumentError.new("Trip saved, but Driver status not updated to active")
      return
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id] )
    if @trip.nil?
      head :not_found
      return
    end

    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to edit_trip_path
      return
    end
  end

  def destroy
    trip = Trip.find_by( id: params[:id] )

    # Because find_by will give back nil if the book is not found...

    if trip.nil?
      # Then the book was not found!
      redirect_to trips_path
      return
    else
      # Then we did find it!
      trip.destroy
      redirect_to root_path
      return
    end
  end

  def add_rating
    trip = Trip.find_by(id: params[:id])

    if trip.nil?
      # Then the book was not found!
      redirect_to trips_path
      return
    end

    driver = trip.driver

    if trip.update(trip_params)
    else
      raise ArgumentError.new("Error! The submitted rating did not save sucessfully.")
    end
      
    if driver.update({active: false})
      redirect_to trip_path(trip.id)
    else
      raise ArgumentError.new("Error! The driver's status did not update to inactive.")
    end

  end
  
  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :driver_id, :passenger_id, :rating)
  end
  
  
end
