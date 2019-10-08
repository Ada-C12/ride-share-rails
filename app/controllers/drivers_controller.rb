class DriversController < ApplicationController
 
 def index
  @drivers = Driver.all
 end
 
 def show
  @driver = Driver.find_by(id: params[:id])
  head :not_found if @driver.nil?
 end
 
end
