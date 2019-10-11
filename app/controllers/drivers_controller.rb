class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end
  
  def show
    @driver = Driver.find_by(id: params[:id])
    head :not_found if @driver.nil?
  end
  
  def new
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.create(driver_params)
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path
    end
  end
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    return redirect_to drivers_path unless @driver
    update_trips
    @driver.destroy
    redirect_to drivers_path
  end
  
  def edit
    @driver = Driver.find_by(id: params[:id])
    return redirect_to drivers_path unless @driver
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    return head :not_found unless @driver
    
    if @driver.update(driver_params)
      redirect_to drivers_path
    else
      render "edit"
    end
  end
  
  def update_trips
    @trips = Trip.where(driver_id: @driver.id)
    @trips.each do |trip|
      trip.driver_id = 101
      trip.save
    end
  end
  
  
  private
  def driver_params
    params.require(:driver).permit(:name, :vin)
  end
end
