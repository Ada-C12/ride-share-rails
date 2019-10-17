class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
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

    if @passenger.nil?
      redirect_to new_passenger_path
      return
    end
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      redirect_to new_passenger_path
      return
    end

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
    else
      redirect_to new_passenger_path
    end
  end

  def destroy
    selected_passenger = Passenger.find_by(id: params[:id])

    if selected_passenger.nil?
      redirect_to passengers_path
    else
      selected_passenger.destroy
      redirect_to root_path
    end
  end

  private
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end

end
