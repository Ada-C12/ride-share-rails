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
    
    if params[:trip][:rating].to_i >= 0 && params[:trip][:rating].to_i <=5
      @trip.update(trip_params)
      @trip.driver.available = true
      @trip.driver.save
      
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
    redirect_to passenger_path
    return
  end
  
  def create    
    trip = Trip.create(
      date: Date.today,
      passenger_id: params[:passenger_id],
      driver_id: Driver.find_a_driver,
      cost: rand(500...10000),
      rating: nil
    )
    
    if trip.id
      trip.driver.available = false
      trip.driver.save
      
      redirect_to passenger_path(params[:passenger_id])
    else
      redirect_to passenger_path(params[:passenger_id])
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit( :rating, :cost)
  end  
end
