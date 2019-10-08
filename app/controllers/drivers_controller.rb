class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render new_driver_path
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      redirect_to root_path
      return
    end
  end

  def destroy
    found_driver = Driver.find_by(id: params[:id])
    if found_driver.nil?
      redirect_to root_path
      return
    else
      found_driver.destroy
      redirect_to root_path
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
