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
    @driver = Driver.create(driver_params)
    if @driver.save
      redirect_to drivers_path
      return
    else
      render :new
      return
    end
  end
  
  
  
  
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
end
