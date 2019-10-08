class DriversController < ApplicationController
  def index
    @drivers = Driver.alpha_drivers
  end

  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
    return 
    end
  end
end
