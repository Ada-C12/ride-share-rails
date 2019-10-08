class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def new
    @driver = Driver.new()
  end
  
  def show
    driver_id = params[:id].to_i
    # Both find and find_by will work... But Dee has a preference for find_by. Why?
    @driver = Driver.find_by(id: driver_id)
    if @drivere.nil?
      head :not_found
      return
    end
  end 

  def create
  end
  
end
