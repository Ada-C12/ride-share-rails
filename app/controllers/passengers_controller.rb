class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all.order(:id)
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(get_params)
    if @passenger.save
      redirect_to passenger_path(id: @passenger.id)
      return
    else
      render new_passenger_path
      return
    end
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      redirect_to nope_path(params: {msg: "No such passenger exists!"})
      return
    end
  end
  
  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to nope_path(params: {msg: "Cannot edit a non-existent passenger!"})
    end
  end
  
  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.update(get_params)
      redirect_to passenger_path(id: @passenger.id)
      return
    else
      render action: 'edit', params: { id: @passenger.id }
      return
    end
  end
  
  def destroy
    garbage = Passenger.find_by(id: params[:id])
    if garbage
      garbage.destroy
      redirect_to passengers_path
    else
      redirect_to nope_path(params: {msg: "Cannot destroy a non-existent passenger record"})
    end
  end
  
  private
  def get_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
