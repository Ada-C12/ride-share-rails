class DriversController < ApplicationController

  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id:driver_id)

    @trips = Trip.where(driver_id: driver_id)

    if driver_id < 0
        redirect_to root_path
    end

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
    if @driver.save
        redirect_to driver_path(@driver.id)
    else
        render new_driver_path
    end
  end

  def edit
    id = params[:id].to_i
    @driver = Driver.find_by(id: id)

    if @driver == nil
      redirect_to driver_path
    end
      
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    unless @driver
      head :not_found
      return
    end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
    else
      render :edit
    end
  end

  def update
    id = params[:id].to_i
    if id < 0
      redirect_to root_path
    end

    @driver = Driver.find_by(id: id)
    @driver[:name] = params[:driver][:name]
    @driver[:vin] = params[:driver][:vin]
    @driver[:available] = params[:driver][:available]

    if @driver.save
      redirect_to driver_path(@driver.id)
    else
      render new_driver_path
    end
  end

  def destroy
    driver_to_delete = Driver.find_by(id: params[:id])
    if driver_to_delete.nil?
      redirect_to driver_path
      return
    else
      driver_to_delete.destroy
      redirect_to drivers_path
      return
    end
  end

  private

  def driver_params
      return params.require(:driver).permit(:name, :vin, :available)
  end

end
