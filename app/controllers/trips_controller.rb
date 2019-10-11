class TripsController < ApplicationController
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
      date: Date.today,
      rating: nil,
      cost: rand(1...5000))
      if @trip.save 
        @trip.driver.toggle_status
        redirect_to passenger_path(@trip.passenger_id)
        return 
      else 
        head :not_found
        return
      end 
    end 
    
    # def edit
    #   @trip = Trip.find_by(id: params[:id])
    #   if @trip.nil? 
    #     head :not_found
    #     return
    #   end 
    # end 
    
    # def update 
    #   @trip = Trip.find_by(id: params[:id])
    #   if @trip.update(trip_params)
    #     #experiment
    #     redirect_to trips_path
    #     return
    #   else 
    #     render :edit
    #     return
    #   end 
    # end 

    def complete_trip
      @trip = Trip.find_by(id: params[:id])
      @trip.assign_rating
      @trip.driver.toggle_status
      redirect_to passenger_path(@trip.passenger.id)
    end 
    
    def destroy 
      trip_id = params[:id]
      @trip = Trip.find_by(id: trip_id)
      deleted_trip_passenger = @trip.passenger
      if @trip.nil? 
        head :not_found
        return
      end 
      @trip.destroy 
      redirect_to passenger_page(deleted_trip_passenger)
      return 
    end 
    
    private 
    
    def trip_params 
      return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
    end 
    
  end
  

