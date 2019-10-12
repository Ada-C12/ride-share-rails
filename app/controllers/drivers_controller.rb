class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end 
  
  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    
    if @driver.nil?
      head :not_found
      return 
    end
  end 
  
  def new 
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin])
    if @driver.save 
      redirect_to drivers_path
      return
    else
      # render :new 
      redirect_to drivers_path
      return 
    end
  end
  
  def edit 
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end
  
  def update 
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path 
    end

    if @driver.update(driver_params)
      redirect_to driver_path
    else
      redirect_to edit_driver_path
      return
      # render :edit
      return
     end
  end
  
  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    
    if @driver.nil?
      redirect_to drivers_path
      return
    elsif @driver.destroy
      redirect_to drivers_path
      return 
    end 
  end
  
  private
  
  def driver_params
    params.require(:driver).permit(:name, :status, :vin) 
  end
  
end

