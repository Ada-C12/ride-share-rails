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

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to driver_path(@driver)
      return
    else
      render :new
      return
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to edit_driver_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
      return
    end
    result = @driver.update(driver_params)
    if result
      redirect_to driver_path(@driver.id)
    else
      render :edit
      return
    end
  end

  def destroy
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      head :not_found
      return
    end
    @driver.destroy
    redirect_to drivers_path
  end

  def toggle_active
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to edit_driver_path
      return
    end
    if @driver.active == false
      @driver.update(active: true)
    elsif @driver.active == true
      @driver.update(active: false)
    end
    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    end
  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
