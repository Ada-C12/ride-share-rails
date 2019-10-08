class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.available = true

    if @driver.save
      redirect_to driver_path(@driver)
      return
    else
      render "new"
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
