class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return 
    end
  end
  
  def create
    # return the first driver whose status is active: false
    assign_driver = Driver.find_by(active: nil)
    # generate a rating between 1 and 5
    rating = rand(1..5)
    # generate a price between 500 and 5000 (will convert to decimal in model)
    cost = rand(500..5000)
    # Use Time.now to get today's date
    long_date = DateTime.now.to_s
    date = long_date[0..9]
    # passenger = Passenger.find_by(id: params[:id])
    # create a new trip with the assigned driver's id
    @trip = Trip.new(driver_id: assign_driver.id, passenger_id: params[:passenger_id], rating: nil, cost: cost, date: date)
    #params[:passenger][:id]
    @trip.save
    #assign the driver's status to active: true
    assign_driver.update(active: true) 
    # provide behavior for if the trip doesn't save
    # binding.pry
    
    # redirect to the passenger page so new trip now appears in trip list
    redirect_to root_path
    return
  else 
    render :new 
    return
  end
end



