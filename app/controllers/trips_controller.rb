class TripsController < ApplicationController
  def index
    @trips = Trip.all
    if @trips.nil?
      head :not_found
      return
    end 
  end 
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil? 
      head :not_found
      return
    end 
  end 
  
  def create 
    @trip = Trip.create(
      passenger_id: params[:passenger_id],
      driver_id: Driver.find_available.id,
      date: Time.now,
      rating: nil,
      cost: rand(1...5000))
      if @trip.save 
        redirect_to passenger_path(params[:passenger_id])
        return 
      else 
        redirect_to passenger_path(params[:passenger_id])
        return
      end 
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
      if @trip.update(trip_params)
        #experiment
        redirect_to trips_path
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
      redirect_to trips_path
      return 
    end 
    
    private 
    
    def trip_params 
      return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
    end 
    
  end
  

