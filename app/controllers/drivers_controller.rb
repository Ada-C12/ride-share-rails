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

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver)
      return
    else
      render "new"
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
      return
    end

    @driver.destroy
    redirect_to drivers_path
    return
  end

  def toggle_available
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to drivers_path
    else
      @driver.available = true
      @driver.save
      redirect_to driver_path(@driver)
    end
  end

  def toggle_unavailable
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      redirect_to drivers_path
    else
      @driver.available = false
      @driver.save
      redirect_to driver_path(@driver)
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end
