class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def create
    @driver = Driver.new( driver_params )
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path
    end
  end
  
  def new
    @driver = Driver.new
  end
  
  def edit
    @driver = Driver.find_by(id: params[:id] )
    if @driver.nil?
      redirect_to drivers_path
    end
  end
  
  def update
    @driver = Driver.find_by(id: params[:id] )
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update( driver_params )
      redirect_to driver_path(@driver.id)
    else
      render :edit
    end
  end
  
  def destroy
    driver = Driver.find_by( id: params[:id] )
    if driver.nil?
      redirect_to drivers_path
      return
    else
      driver.trips.each do |trip|
        trip.destroy
      end
      driver.destroy
      redirect_to drivers_path
      return
    end
  end
  
  def status
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.active == false
      @driver.active = true
    else
      @driver.active = false
    end
    
    @driver.save
    redirect_to driver_path(@driver.id)
    
  end
  
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
