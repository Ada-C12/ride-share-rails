class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      head :not_found
      return
    end
    
    # @trip.replaced_deleted
  end
  
  def create
    @trip = Trip.new(creation_params)
    
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
      head :not_found
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      head :not_found
      return
    end
    
    
    if @trip.update(changes_params)
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
      head :not_found
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
      head :not_found
      return
    end
  end
  
  def assign_rating_update
    @trip = Trip.find_by(id: params[:id])
    
    # might need more work later
    if @trip.nil?
      head :not_found
      return
    end
    
    if @trip.update(rating: params[:trip][:rating])
      redirect_to trip_path(@trip.id)
      return
    else
      render :assign_rating_edit
      return
    end
  end
  
  private
  
  def creation_params
    return params.require(:trip).permit(:date, :cost, :passenger_id, :driver_id)
  end
  
  def changes_params
    return params.require(:trip).permit(:date, :cost, :passenger_id, :driver_id, :rating)
  end
  
end
