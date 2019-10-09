class DriversController < ApplicationController
  before_action :set_driver, only: [:show, :edit, :update, :destroy]
  
  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.all
  end
  
  # GET /drivers/1
  # GET /drivers/1.json
  def show
    # @driver
    # @trips = Driver.find_trips
    # @trips = Trip.all
    
  end
  
  # GET /drivers/new
  def new
    @driver = Driver.new
  end
  
  # GET /drivers/1/edit
  def edit
  end
  
  # POST /drivers
  # POST /drivers.json
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
  
  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
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
  
  # DELETE /drivers/1
  # DELETE /drivers/1.json
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
  # Use callbacks to share common setup or constraints between actions.
  def set_driver
    @driver = Driver.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def driver_params
    params.require(:driver).permit(:name, :vin, :active, :car_make, :car_model)
  end
end
