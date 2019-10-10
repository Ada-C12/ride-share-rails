class TripsController < ApplicationController
  
  def index
  end
  
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
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
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    @trip.destroy if @trip
    
    redirect_to root_path
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver, :passenger)
  end
end
