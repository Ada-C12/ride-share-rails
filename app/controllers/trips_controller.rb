class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def create
    @trip = Trip.new(trip_params)
    
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      # might not be render :new
      render :new
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
    
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
    
    @trip.destroy
    redirect_to passenger_path(@trip.passenger_id)
  end
  
  # Can you just use normal edit's code
  def assign_rating_edit
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def assign_rating
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      redirect_to root_path
      return
    end
    
    if @trip.update(rating_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :assign_rating_edit
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :cost, :passenger_id, :driver_id)
  end
  
  def rating_params
    return params.require(:trip).permit(:rating)
  end
  
end
