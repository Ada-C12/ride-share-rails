class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end

  def show
    passenger_id = params[:id].to_i
    @passenger = Passenger.find_by(id:passenger_id)
    if @passenger.nil?
      redirect_to passengers_path
      return
    end

  end


end
