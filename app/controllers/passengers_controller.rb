class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end 

  def show
    passenger_id = params[:id].to_i

    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      head :not_found
      return 
    end 
  end 

  def new
    @passenger = Passenger.new
  end 

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else 
      render new_passenger_path 
    end 
  end 

  def edit
    @passenger = Passenger.find_by(id: params[:id])
  end 

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
    else 
      render new_passenger_path
    end 
  end 

  def destroy
    valid_passenger = Passenger.find_by(id:params[:id])

    if valid_passenger.nil?
      redirect_to passengers_path
      return
    else 
      valid_passenger.destroy
      redirect_to passengers_path 
      return
    end 
  end

  
  private
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end 

end
