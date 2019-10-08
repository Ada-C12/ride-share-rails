class PassengersController < ApplicationController
  
  def index
    @passengers = Passenger.all
  end
  
  def new
    @passenger = Passenger.new
  end
  
  def create
    @passenger = Passenger.new(get_params)
    if @passenger.valid?
      x = "success"
      raise
      return
    else
      x = "bad args"
      raise
      return
    end
  end
  
  def show
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger
      @msg = "HOW DO I ADD THIS??? No such passenger exists!"
      redirect_to nope_path
      return
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  
  private
  def get_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
