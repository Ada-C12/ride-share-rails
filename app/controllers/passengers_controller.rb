class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id: passenger_id)

    @trips = Trip.where(passenger_id: passenger_id)

    if passenger_id < 0
      redirect_to root_path
    end

    if @passenger.nil?
      redirect_to new_passenger_path
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

    id = params[:id].to_i
    @passenger = Passenger.find_by(id: id)
    if @passenger == nil
      redirect_to passenger_path
    end
  end

  def update

    id = params[:id].to_i
    if id < 0
      redirect_to root_path
    end

    @passenger = Passenger.find_by(id: id)

    @passenger[:name]= params[:passenger][:name] 
    @passenger[:phone_num] = params[:passenger][:phone_num]

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    else
      render edit_passenger_path
    end
  end

  def destroy
    the_correct_passenger = Passenger.find_by( id: params[:id] )

    if the_correct_passenger.nil?
      redirect_to passengers_path
      return
    else
      the_correct_passenger.destroy
      redirect_to passengers_path
      return
    end
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
