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
    assigned_driver = Driver.find_by(active: false)
    # generate a rating between 1 and 5
    rating = rand(1..5)
    # generate a price between 500 and 5000 (will convert to decimal in model)
    cost = rand(500..5000)
    # Use Time.now to get today's date
    long_date = DateTime.now.to_s
    date = long_date[0..9]
    passenger_id = Passenger.find_by(id: params[:id]).id
    # create a new trip with the assigned driver's id
    @trip = Trip.new(driver_id: assigned_driver.id, passenger_id: passenger_id, rating: rating, cost: cost, date: date)
    #assign the driver's status to active: true
    assigned_driver.update(active: true) 
    # save the new trip
    # provide behavior for if the trip doesn't save
    @trip.save
    # redirect to the passenger page so new trip now appears in trip list
    redirect_to passenger_path(@passenger.id) 
    return
  else 
    render :new 
    return
  end
end



