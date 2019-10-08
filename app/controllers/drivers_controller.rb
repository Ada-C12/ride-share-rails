class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def create
    @driver = Driver.new( strongs_params )
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path
    end
  end
  
  def new
    @driver = Driver.new
  end
  
  
  private
  
  def strongs_params
    return params.require(:driver).permit(:name, :vin)
  end
end
