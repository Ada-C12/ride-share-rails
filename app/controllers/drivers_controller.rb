class DriversController < ApplicationController
 def index
  @drivers = Driver.all
 end
 
 def show
  @driver = Driver.find_by(id: params[:id])
  head :not_found if @driver.nil?
 end

 def new
   @driver = Driver.new
 end

 def create
   Driver.create(driver_params)
 end

 def destroy
   driver = Driver.find_by(id: params[:id])
   driver.destroy
   redirect_to drivers_path
 end

 private
 def driver_params
   params.require(:driver).permit(:name, :vin)
 end
end
