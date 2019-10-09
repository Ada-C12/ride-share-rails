class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to passengers_path
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
    if @passenger == nil
      redirect_to passenger_path
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger == nil
      redirect_to passengers_path
      return
    end

    @passenger.name = params[:passenger][:name]
    @passenger.phone_num = params[:passenger][:phone_num]

    if @passenger.save
      redirect_to passenger_path(@passenger.id)
    end
  end

  def destroy
    the_correct_passenger = Passenger.find_by( id: params[:id] )

    if the_correct_passenger.nil?
      redirect_to passengers_path
      return
    else
      the_correct_passenger.destroy
      redirect_to root_path
      return
    end
  end

  def total_money_spent
  end

  private

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
