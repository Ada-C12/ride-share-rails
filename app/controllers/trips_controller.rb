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
    @trip = trip.new
  end
  
  def create
    @trip = Trip.new(Trip_params) 
    # Assign passenger from params
    # Assign a driver
    if @trip.save
      redirect_to root_path 
      return
    else
      render :new 
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.update(trip_params)
      redirect_to root_path 
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    end
    
    @trip.destroy
    redirect_to root_path
    return
  end
  
  # Check route path and check find_a_driver method before working on tests...
  def create
    trip = Trip.create(
      date: Date.today,
      passenger_id: params[:id],
      driver_id: Driver.find_a_driver,
      cost: (Trip.first.cost)
    )
    
    if trip.id
      redirect_to root_path
    else
      head :server_error
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit( :rating, :cost)
  end
end
