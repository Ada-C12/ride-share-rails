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
    @driver = Driver.new(driver_params) rescue nil
    if @driver
      successful = @driver.save
      if successful
        redirect_to driver_path(@driver.id)
        return
      end
    end
    
    render :new
    return
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
    else
      if @driver.update(driver_params)
        redirect_to driver_path(@driver.id)
        return
      else
        render :edit
        return
      end
    end
  end
  
  def destroy
    selected_driver = Driver.find_by(id: params[:id])
    if selected_driver
      selected_driver.destroy
    end

    redirect_to drivers_path
    return
  end
  
  def toggle
    @driver = Driver.find_by(id: params[:id])
    if @driver
      @driver.toggle_active
      @driver.save
      redirect_to driver_path(@driver.id)
      return
    end   
    
    head :not_found
    return
  end

  private
  def driver_params
    return params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
