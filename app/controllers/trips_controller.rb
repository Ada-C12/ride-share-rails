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
    if params[:passenger_id]
      # :date, :cost, :passenger_id, :driver_id
      new_date = Time.now
      new_cost = rand(10..80)
      new_passenger_id = params[:passenger_id]
      new_driver_id = Driver.find_available.id
      @trip = Trip.new(date: new_date, cost: new_cost, passenger_id: new_passenger_id, driver_id: new_driver_id)
    elsif creation_params
      @trip = Trip.new(creation_params)
    end
    
    if @trip.save
      # You need to call a method that will toggle driver status to inactive
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
