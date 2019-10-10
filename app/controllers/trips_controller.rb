class TripsController < ApplicationController
  def index
    redirect_to root_path
    return
  end
  
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def new
    @trip = Trip.new
  end
  
  def create
    if params[:trip].nil?
      redirect_to new_trip_path
    end
    
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
      redirect_to trip_path(@trip.id)
      return
    end 
  end
  
  def update 
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path
      return
    else
      render :edit
      return
    end 
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    @trip.destroy if @trip
    
    redirect_to root_path
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
end
