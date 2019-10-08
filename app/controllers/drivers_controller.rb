class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def create
    @driver = Driver.new( strongs_params )
    @driver.save
  end
  
  
  private
  
  def strongs_params
    return params.require(:driver).permit(:name, :vin)
  end
end
