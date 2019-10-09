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

  def edit
    show #same as show method, so I just called the method for DRY
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to root_path
      return
    elsif @driver.update(
      name: params[:driver][:name], 
      vin: params[:driver][:vin],
      car_make: params[:driver][:car_make],
      car_model: params[:driver][:car_model]
    )
      redirect_to drivers_path 
      return
    else 
      render :edit 
      return
    end
  end

  def destroy
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end

    @driver.destroy
    redirect_to drivers_path
    return
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin], car_make: params[:driver][:car_make], car_model: params[:driver][:car_model], active: params[:driver][:active]) 
    if @driver.name != ""
      @driver.save
      redirect_to driver_path(@driver.id) 
      return
    else 
      render :new 
      return
    end
  end
end
