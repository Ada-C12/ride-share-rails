class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return 
    end
  end
  
  def create
    assign_driver = Driver.find_by(active: nil)
    rating = rand(1..5)
    cost = rand(500..5000)
    long_date = DateTime.now.to_s
    date = long_date[0..9]
    
    @trip = Trip.new(driver_id: assign_driver.id, passenger_id: params[:passenger_id], rating: nil, cost: cost, date: date)
    @trip.save
    assign_driver.update(active: true) 
    
    redirect_to passenger_path(params[:passenger_id])
      
    return
  else 
    render :new 
    return
  end

  def update
    # @trip = Trip.find_by(id: params[:trip_id])
    
    if @trip.rating == nil
      @trip.update(rating: params[:trip][:rating])
      redirect_to trip_path 
      return
    else 
      render :edit 
      return
    end
  end
end


