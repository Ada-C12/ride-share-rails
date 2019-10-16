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
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver)
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
    
    if @driver.update(driver_params)
      redirect_to drivers_path(@driver)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      flash[:error] = "Could not find driver ID #{ params[:id] }"
      redirect_to drivers_path
      return
    end 
    
    @driver.destroy
    redirect_to drivers_path
    return
  end
  
  def mark_online
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      flash[:error] = "Could not find driver ID #{ @driver.id }"
      redirect_to drivers_path
      return
    end
    
    @driver.update(active: false)
    redirect_to driver_path(@driver)
    return 
  end 
  
  
  def mark_offline
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      flash[:error] = "Could not find driver ID #{ @driver.id }"
      redirect_to drivers_path
      return
    end
    
    @driver.update(active: true)
    redirect_to driver_path(@driver)
    return 
  end 
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
end