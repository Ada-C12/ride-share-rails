class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
  end
  
  
  
  
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
end
