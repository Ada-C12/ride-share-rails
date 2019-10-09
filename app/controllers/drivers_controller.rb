class DriversController < ApplicationController
  def index
    @drivers = Driver.all_by_id_desc
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.create(driver_params)
    if @driver.id?
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path, status: :unprocessable_entity
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end


end
