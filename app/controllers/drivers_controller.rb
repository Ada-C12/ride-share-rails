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
      redirect_to driver_path(@driver.id)
      return
    else
      render new_driver_path
      return
    end
  end
  
  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    driver = Driver.find_by(id: params[:id])
    
    if driver.nil?
      redirect_to drivers_path
      return
    else
      driver.destroy
      redirect_to drivers_path
      return
    end
  end
  
  def make_active
    @driver = Driver.find_by(id: params[:id])

    @driver.make_active
    redirect_to driver_path(@driver.id)
  end

  def make_inactive
    @driver = Driver.find_by(id: params[:id])

    @driver.make_inactive
    redirect_to driver_path(@driver.id)
  end
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
