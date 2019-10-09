class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
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
      return
    else
      redirect_to new_driver_path
      return
    end
  end
  
  def edit
    @driver = Driver.find_by(id: params[:id])
      
    if @driver.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id] )
      if @driver.nil?
        head :not_found
        return
      end

    if @driver.update(driver_params)
      redirect_to driver_path(@driver.id)
      return
    else
      redirect_to edit_driver_path
      return
    end
  end
  
  def destroy
    driver = Driver.find_by( id: params[:id] )

    # Because find_by will give back nil if the book is not found...

    if driver.nil?
      # Then the book was not found!
      redirect_to drivers_path
      return
    else
      # Then we did find it!
      driver.destroy
      redirect_to root_path
      return
    end
  end


  private
  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
  
  
end
