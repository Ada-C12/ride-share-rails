class TripsController < ApplicationController
  
  def index
    # Where did the request come from?  Per passenger? or per driver? or per trips index?
    @passenger = Passenger.find_by(id: params[:passenger_id])
    @driver = Driver.find_by(id: params[:driver_id])
    if @driver
      # showing trips for a specific driver
      @trips = Trip.where(driver_id: @driver.id)
    elsif @passenger
      # showing trips for a specific passenger
      @trips = Trip.where(passenger_id: @passenger.id)
      @can_rate = true
    else
      # just showing all Trips table for all passengers
      @trips = Trip.all
    end
  end
  
  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil? 
      if params[:id] == "new"
        # trying to request new trips via /trips/new? even though routes blocked? nice try!
        redirect_to nope_path(params: {msg: "Only passengers can request/create trips!"})
        return
      else
        # trying to request new trips 
        redirect_to nope_path(params: {msg: "No such trip exists!"})
        return
      end
    end 
    
    # this way I can use _trips_table.html.erb for single entry too
    @trips = [@trip]
  end
  
  def create
    # find available driver
    @driver = Driver.find_by(active: false)
    if @driver.nil?
      redirect_to nope_path(params: {msg: "No drivers available, maybe you should walk"})
      return
    else
      # flip @driver.active to true.  
      unless @driver.update(active: true)
        redirect_to nope_path(params: {msg: "Unexpected error, please call customer service at 1-800-LOL-SORRY"})
        return
      end   
      # puts "DOUBLE CHECK flipped to true? #{@driver.active}"
      
      
      
      # When do we flip it back to false? Normally we'd do that when GPS hits destination...
      # For this project, we'll flip it when passenger rates the trip.
    end   
    
    # make new trip
    @trip = Trip.new(date: params[:date], rating: nil, cost: 1000, driver_id: @driver.id, passenger_id: params[:passenger_id])
    if @trip.save
      redirect_to trip_path(@trip.id)
      return
    else
      # bad passenger_id triggers this
      redirect_to nope_path(params: {msg: "Trip request unsuccessful, please contact customer service at 1-800-lol-sorry"})
      return
    end
  end
  
  def edit
    # individual passenger uses this to update ratings
    @trip = Trip.find_by(id:params[:id])
    if @trip.nil?
      redirect_to nope_path(params: {msg: "No such trip exists!"})
      return
    else
      @trips = [@trip]
      @rating = nil
    end
  end 
  
  def update
    # individual passenger uses this to update ratings
    @trip = Trip.find_by(id: params[:id])
    driver_id = @trip.driver_id
    passenger_id = @trip.passenger_id
    rating = params[:rating].to_i
    
    if rating.nil?
      redirect_to nope_path(params: {msg: "No rating given!"})
      return
    elsif @trip.nil?
      redirect_to nope_path(params: {msg: "No such trip exists!"})
      return
    elsif @trip.update(rating: rating)
      # need to flip driver.active back to false, so they can work again
      driver = Driver.find_by(id: driver_id)
      if driver.update(active: false)
        redirect_to passenger_trips_path(passenger_id: passenger_id)
        return
      else
        redirect_to nope_path(params: {msg: "Unable to switch driver.active back to false, please call customer service at 1-800-LOL-SORRY"})
      end
    else
      redirect_to nope_path(params: {msg: "Unable to update rating, please call customer service at 1-800-LOL-SORRY"})
      return
    end
  end 
  
  def destroy
    # Only passengers can delete their own trips via links
    selected_trip = Trip.find_by(id: params[:id])
    
    if selected_trip.nil?
      redirect_to nope_path(params: {msg: "No such trip exists!"})
      return
    else
      selected_trip.destroy
      redirect_to passenger_path(id: selected_trip.passenger_id)
      return
    end
  end 
  
end

