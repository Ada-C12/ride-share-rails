class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    end
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(passenger_params) rescue nil
    if @passenger
      successful = @passenger.save
      if successful
        redirect_to passenger_path(@passenger.id)
        return
      end
    end
    
    redirect_to new_passenger_path
    return
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to passengers_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    else
      if @passenger.update(passenger_params)
        redirect_to passenger_path(@passenger.id)
        return
      else
        redirect_to edit_passenger_path
        return
      end
    end
  end

  def destroy
    selected_passenger = Passenger.find_by(id: params[:id])
    if selected_passenger
      selected_passenger.destroy
    end

    redirect_to passengers_path
    return
  end
  
  private 
  
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num) 
  end
end
