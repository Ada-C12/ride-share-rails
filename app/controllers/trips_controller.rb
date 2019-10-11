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
  
  # Creates a trip for a specific passenger with an available driver...
  # Sam - Update path and check find_a_driver method before working on tests...
  def create
    trip = Trip.create(
      date: Date.today,
      passenger_id: params[:id],
      driver_id: Driver.find_a_driver,
      cost: (Trip.first.cost)
    )
    
    if trip.id
      redirect_to passenger_path
    else
      render :new
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit( :rating, :cost)
  end
end
