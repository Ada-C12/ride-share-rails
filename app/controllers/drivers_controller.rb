class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end
  
  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to drivers_path
    end
  end
  
  def new
    @driver = Driver.new
  end
  
  def create
    @driver = Driver.new( driver_params )
    
    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render new_driver_path
    end
    
  end
  
  def edit
    @driver = Driver.find_by( id: params[:id] )
    
    if @driver.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      redirect_to root_path
      return
    end
    
    if @driver.update( driver_params )
      redirect_to driver_path(@driver.id)
      return
    else
      render edit_driver_path(@driver.id)
      return
    end
  end
  
  def destroy
    the_correct_driver = Driver.find_by(id:params[:id])
    if the_correct_driver.nil?
      redirect_to drivers_path
      return
    else
      the_correct_driver.destroy
      redirect_to root_path
    end
  end
  
  private
  
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
end
