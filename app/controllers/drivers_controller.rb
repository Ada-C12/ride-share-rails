class DriversController < ApplicationController
  
  def index
    @drivers = DriversController.all 
  end 
  
  def show
    DriversController_id = params[:id].to_i
    
    @DriversController = DriversController.find_by(id: DriversController_id)
    
    if @DriversController.nil?
      head :not_found
      return 
    end 
  end 
  
  def edit
    @DriversController = DriversController.find_by(id: params[:id])
  end 
  
  def update
    @DriversController = DriversController.find_by(id: params[:id])
    
    if @DriversController.update(DriversController_params)
      redirect_to DriversController_path(@DriversController_id)
    else 
      render new_DriversController_path
    end 
  end 
  
  def destroy
    valid_DriversController = DriversController.find_by(id:params[:id])
    
    if valid_DriversController.nil?
      redirect_to DriversController_path
      return
    else 
      valid_DriversController.destroy
      redirect_to DriversController_path 
      return
    end 
  end
  
  
  private
  def DriversController_params
    return params.require(:DriversController).permit(:id, :name, :vin)
  end 
  
end
