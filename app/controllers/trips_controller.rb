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
  end
  
  def create
    @trip = Trip.new(trip_params)
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
      redirect_to root_path
      return
    end
  end 
  
  def update
    # individual passenger uses this to update ratings
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to nope_path
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      redirect_to nope_path
    end
  end 
  
  def destroy
    ### DO WE EVEN NEED TO DO THIS?
    selected_trip = Trip.find_by(id: params[:id])
    
    if selected_trip.nil?
      redirect_to nope_path(params: {msg: "No such trip exists!"})
      return
    else
      selected_trip.destroy
      redirect_to trip_path
      return
    end
  end 
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
  
end
