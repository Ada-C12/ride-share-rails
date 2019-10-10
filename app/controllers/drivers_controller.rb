class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end 

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
  end 

  def new
    @driver = Driver.new
  end 

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def create
    @driver = Driver.new(name: params[:driver][:name], vin: params[:driver][:vin])
    
    if @driver.save
      redirect_to drivers_path
      return
    else
      render :new
      return
    end
  end 
  
  def destroy
    @driver = Driver.find_by(id: params[:id])
    @driver.destroy
    redirect_to drivers_path
    return
  end 

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.update(name: params[:driver][:name], vin: params[:driver][:vin])
      redirect_to passengers_path
      return
    else
      render :edit
      return
    end 
  end 

  # def create
  #   @driver = Driver.new(name: params[:driver][:name], description: params[:driver][:vin])

  #   if @driver.name == " "
  #     redirect_to drivers_path
  #     return
  #   end 
  # end 

  # This should happen once "create" is hit
  # "New" is the page with the form
end
