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

  def edit
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
      return
    elsif @driver.destroy
      redirect_to drivers_path
      return
    else
      render :index
    end
  end

  def toggle_active
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to root_path, status: :not_found
    else
      @driver.toggle!(:active)
      render :show
      return
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end


end
