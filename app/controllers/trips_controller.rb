class TripsController < ApplicationController
  
  def index
    @trips = Trip.all
  end
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def new
    if (params[:trip][:rating]).to_i > 5
      flash[:error] = "The rating can't be higher than 5"
    else
      if params[:passenger_id]
        @passenger = Passenger.find_by(id: params[:passenger_id])
        @trip = @passenger.trips.new
      else
        @trip = Trip.new
      end
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
    if (params[:trip][:rating]).to_i > 5
      flash[:error] = "The rating can't be higher than 5"
    else
      @trip = Trip.find_by(id: params[:id])
      if @trip.nil?
        head :not_found
        return
      end
      
      respond_to do |format|
        if @trip.update(trip_params)
          format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        end
      end
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
    end
  end
  
  private

  def trip_params
    params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
