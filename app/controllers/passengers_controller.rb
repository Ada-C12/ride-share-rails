class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
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
      return
    else
      redirect_to new_passenger_path
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    
    if @passenger.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id] )
    if @passenger.nil?
      head :not_found
      return
    end

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
      return
    else
      redirect_to edit_passenger_path
      return
    end
  end

  def destroy
    passenger = Passenger.find_by( id: params[:id] )

    # Because find_by will give back nil if the book is not found...

    if passenger.nil?
      # Then the book was not found!
      redirect_to passengers_path
      return
    else
      # Then we did find it!
      passenger.destroy
      redirect_to root_path
      return
    end
  end


  
  private
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
  
end
