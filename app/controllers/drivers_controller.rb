class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end
  
  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if !@driver
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params) rescue nil
    if @driver
      successful = @driver.save
      if successful
        redirect_to driver_path(@driver.id)
        return
      end
    end

    redirect_to new_driver_path
    return
  end

  
  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
