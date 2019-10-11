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
    @trip = Trip.new
  end
  
  def create
    @trip = Trip.new() 
    # Assign passenger from params
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @trip.passenger = @passenger
    
    if @passenger.nil?
      head :not_found
      return
    end
    
    # TODO: Change to a driver without a trip in progress
    # Assign a driver
    @driver = Driver.first
    @trip.driver = @driver
    
    @trip.cost = 36
    @trip.date = Date.today
    
    if @trip.save
      redirect_back fallback_location: passenger_path(params[:passenger_id]) 
      return
    else
      head :server_error
      # render :new 
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
  
  private
  
  def trip_params
    return params.require(:trip).permit( :rating, :cost)
  end  
end 


