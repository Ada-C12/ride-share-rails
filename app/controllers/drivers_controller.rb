class DriversController < ApplicationController

  def index
    @drivers = Driver.all
  end
  
  def show
    driver_id = params[:id]
    @pdriver = Driver.find_by(id: driver_id)
    
    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def new
    @driver = Driver.new
  end
  
  def edit
  end
  
  def create
    @driver = Driver.new(driver_params)
    
    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
        format.json { render :show, status: :created, location: @driver }
      else
        format.html { render :new }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @driver.update(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @driver.destroy
    respond_to do |format|
      format.html { redirect_to drivers_url, notice: 'Driver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def toggle_status
    driver_id = params[:id]
    @driver= Driver.find_by(id: driver_id)
    if @driver.active == true
      @driver.active = false
    elsif @driver.active == false
      @driver.active = true
    end
    @driver.save
    redirect_to drivers_path
  end 
  
  # def active
  #   if @driver.update_attribute(:active, true)
  #     flash[:success] = "Driver has successfully set as active!" 
  #   else 
  #     flash[:error] = "Uh Oh! Something went wrong."
  #   end
  
  #   redirect_to driver_path(@driver)
  # end
  
  # def inactive
  #   if 
  
  # end 
  
  private
  
  def driver_params
    params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
