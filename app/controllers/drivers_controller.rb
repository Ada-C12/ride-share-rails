class DriversController < ApplicationController
  
  def index
    @drivers = Driver.order(:name)
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
    if !params.nil?
      @driver = Driver.new(driver_params)
      
      if @driver.save
        redirect_to driver_path(@driver.id)
        return
      end
    end
    
    redirect_to new_driver_path
    # render :new
    return
    
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def driver_params
    if !params(:driver).nil?
      return params.require(:driver).permit(:name, :active, :vin, :car_make, :car_model)
    else
      return nil
    end
  end
end
