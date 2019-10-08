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
  
  def edit
  end
  
  def update
    #Handle Validation Errors
  end
  
  def new
  end
  
  def create
    #Handle Validation Errors
  end
end
