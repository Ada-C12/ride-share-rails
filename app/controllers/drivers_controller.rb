class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end
  
  def new
    @driver = Driver.new()
  end
  
  def show
    driver_id = params[:id].to_i
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
      redirect_to driver_path(@driver.id)
    else
      redirect_to nope_path
    end
  end

  def edit
    @driver = Driver.find_by(id:params[:id])

    if @driver.nil?
      redirect_to root_path
      return
    end
  end 

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      redirect_to nope_path
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      redirect_to nope_path
    end
  end 

  def destroy
    selected_driver = Driver.find_by(id: params[:id])

    if selected_driver.nil?
      redirect_to root_path
      return
    else
      selected_driver.destroy
      redirect_to driver_path
      return
    end
  end 

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
