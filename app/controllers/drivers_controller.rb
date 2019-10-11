class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end 
  
  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
  end 
  
  def new 
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin])
    if @driver.save 
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return 
    end
  end
  
  def edit 
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to driver_path
      return
    end
  end
  
  def update 
    @driver = Driver.find_by(id: params[:id])
    
    
    if @driver.update(driver_params)
      redirect_to driver_path
    else
      render :edit
      return
    end
  end
  
  def completed
  end
  
  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    
    @driver.destroy 
    redirect_to drivers_path
  end
  
  private
  
  def driver_params
    params.require(:driver).permit(:name, :status, :vin) 
  end
  
end

