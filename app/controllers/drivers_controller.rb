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
end
