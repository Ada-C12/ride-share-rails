class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      redirect_to new_driver_path
    end
  end

  def new
    @driver = Driver.new
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if !@driver
      redirect_to drivers_path
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if !@driver
      redirect_to drivers_path
      return
    end
    @driver.name = params[:driver][:name]
    @driver.vin = params[:driver][:vin]
    @driver.car_make = params[:driver][:car_make]
    @driver.car_model = params[:driver][:car_model]

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      redirect_to new_driver_path
    end
  end

  def destroy
    driver_to_delete = Driver.find_by(id: params[:id])
    if driver_to_delete.nil?
      redirect_to drivers_path
      return
    else
      driver_to_delete.destroy
      redirect_to drivers_path
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
