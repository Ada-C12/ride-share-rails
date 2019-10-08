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
      render new_driver_path
    end
  end

  def new
    @driver = Driver.new
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if !@driver
      redirect_to edit_driver_path
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if !@driver
      redirect_to edit_driver_path
      return
    end
    @driver.name = params[:driver][:name]
    @driver.description = params[:driver][:description]
    @driver.completed = params[:driver][:completed]

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
