class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end 

  def show
    @driver = Driver.find_by(id: driver_id)
    @driver.trips 
    return @driver.trips 
    
  
  end 
end
