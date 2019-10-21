class DriversController < ApplicationController
  def index
    @drivers = Driver.alpha_drivers
  end
  
  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
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
    elsif @driver.update(
      name: params[:driver][:name], 
      vin: params[:driver][:vin],
      active: params[:driver][:active],
      car_make: nil,
      car_model: nil)
      redirect_to driver_path(@driver.id) 
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      head :not_found
      return
    end
    
    @driver.destroy
    redirect_to drivers_path
    return
  end
  
  def new
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin], car_make: nil, car_model: nil, active: false) 
    if @driver.save
      redirect_to driver_path(@driver.id) 
      return
    else 
      render :new 
      return
    end
  end
  
  
  def active
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.active == false || @driver.active == nil
      @driver.update(active: true)
    else
      @driver.update(active: false)
    end
    redirect_to drivers_path
  end
  
end
