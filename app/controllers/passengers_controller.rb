class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id:passenger_id)
    if @passenger.nil?
      redirect_to tasks_path
      return
    end

  end


end
