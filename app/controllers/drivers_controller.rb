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
  
  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def create
    @driver = Driver.new(driver_params)
    @driver.active = false
    
    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    end
    
    respond_to do |format|
      if @driver.update(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    end
    
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to drivers_url, notice: 'Driver was successfully destroyed.' }
    end
  end
  
  def toggle_status
    driver_id = params[:id]
    @driver= Driver.find_by(id: driver_id)
    if @driver.active == true
      @driver.active = false
      @driver.save
    elsif @driver.active == false
      @driver.active = true
      @driver.save
    end
    redirect_to drivers_path
  end 

  private
  
  def driver_params
    params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
