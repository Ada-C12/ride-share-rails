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
    @trip = Trip.new
  end
  
  def create
    @trip = Trip.new(trip_params)
    
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to new_trip_path
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


  
  private
  def trip_params
    return params.require(:trip).permit(:date, :cost, :driver_id, :passenger_id, :rating)
  end
  
  
end
