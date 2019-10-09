class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def create   
    # call driver to get a driver
    driver = Driver.get_driver
    
    if driver == nil
      flash[:notice] = "There are no available drivers."
      redirect_to passenger_path(params[:passenger_id])
      return
    end
    
    date = DateTime.now
    
    # generate random cost
    # all costs are four digits
    # effectively, $10.00-$99.99
    cost = rand(1000..9999).to_i
    
    data_hash = {
    date: date,
    driver_id: driver.id,
    passenger_id: params[:passenger_id],
    rating: nil,
    cost: cost,
  }
  
  @trip = Trip.new(data_hash)
  
  if @trip.save
    redirect_to passenger_path(@trip.passenger_id)
    return
  else
    redirect_to root_path
    return
  end
end

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
