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
    @driver = Driver.create(driver_params)
    if @driver.save
      redirect_to drivers_path
      return
    else
      render :new
      return
    end
  end
  
  def edit
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    
    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def update
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      head :not_found
      return
    end

    if @driver.update(driver_params)
      redirect_to drivers_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    
    if @driver.nil?
      head :not_found
      return
    end
    
    @driver.destroy
    
    redirect_to drivers_path
    return
  end
  
  
  
  
  # Added make and model to permit below
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
end
