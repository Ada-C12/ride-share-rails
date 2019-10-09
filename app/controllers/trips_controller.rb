class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def create    
    if !(params[:trip].nil?)
      @trip = Trip.new(trip_params)
      
      if @trip.save
        redirect_to passenger_path(@trip.passenger_id)
        return
      end
    else
      redirect_to root_path
      return
    end
  end
  
  # def request_trip
  #   passenger_id = params[:id]
  #   @passenger = Passenger.find_by(id: passenger_id)
  
  #   if @passenger.nil?
  #     redirect_to passengers_path
  #     return
  #   end
  
  #   #call driver to get a driver
  #   driver = Driver.all.first
  #   date = DateTime.now
  
  #   trip_params = {
  #     trip: {
  #       date: date,
  #       driver_id: driver.id,
  #       passenger_id: passenger_id,
  #       rating: nil,
  #       cost: nil,
  #     }
  #   }
  
  #   redirect_to trips_path, params: trip_params
  #   # redirect_to root_path
  #   return
  # end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to root_path
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id)
  end
  
end
