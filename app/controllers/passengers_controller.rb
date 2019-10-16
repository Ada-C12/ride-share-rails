class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end
  
  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    
    if @passenger.nil?
      flash[:error] = "Could not find passenger ID #{ @passenger.id }"
      render passengers_path
      return
    end
  end
  
  def new
    @passenger = Passenger.new
  end 
  
  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passenger_path(@passenger)
      return
    else
      render :new
      return
    end
  end 
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      flash[:error] = "Could not find passenger ID #{ params[:id] }"
      redirect_to passengers_path
      return
    end 
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.update(passenger_params)
      redirect_to passengers_path(@passenger)
      return
    else 
      render :edit
      return
    end
  end
  
  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      flash[:error] = "Could not find passenger ID #{ params[:id]}"
      redirect_to passengers_path
      return
    end 
    
    @passenger.destroy
    redirect_to passengers_path
    return
  end
  
  private
  
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
  
end