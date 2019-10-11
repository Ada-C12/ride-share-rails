class DriversController < ApplicationController
  def index
    @drivers = Driver.order(:name)
  end
  
  def show
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end
  
  def new
    @driver = Driver.new
  end
  
  def create
    if params[:driver].nil?
      redirect_to new_driver_path
      return
    end
    
    @driver = Driver.new(driver_params)
    
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
      redirect_to drivers_path
      return
    end 
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      redirect_to drivers_path
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    
    @driver.destroy if @driver
    
    redirect_to drivers_path
  end
  
  def toggle
    @driver = Driver.find_by(id: params[:id])
    @driver.toggle_available
    
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin, :car_make, :car_model, :available)
  end
end
