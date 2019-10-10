class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
      return 
    end
  end
  
  
  def create
    assigned_driver = Driver.find_by(active: false)
    @trip = Trip.new(driver_id: assigned_driver[:id], )
    assigned_driver.update(active: true) # update driver status to unavailable
    @trip.save
    redirect_to passenger_path(@passenger.id) 
    return
  else 
    render :new 
    return
  end
end


end
