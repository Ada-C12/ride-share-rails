class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all.order(:id)
  end
  
  def new
    @driver = Driver.new()
  end
  
  def show
    driver_id = params[:id].to_i
    @driver = Driver.find_by(id:params[:id])
    if @driver.nil?
      redirect_to nope_path
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
  
  def edit
    @driver = Driver.find_by(id:params[:id])
    
    if @driver.nil?
      redirect_to root_path
      return
    end
  end 
  
  def update
    # binding.pry
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
      redirect_to nope_path
      return
    else
      selected_driver.destroy
      redirect_to drivers_path
      return
    end
  end 
  
  def active
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      redirect_to root_path
      return
    else
      @driver.active = !@driver.active
      @driver.save
      redirect_to driver_path(@driver.id)
      return
    end
  end 
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
