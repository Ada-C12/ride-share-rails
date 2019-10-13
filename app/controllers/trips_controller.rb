class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      
      if passenger.nil?
        redirect_to passengers_path
      end
      
      @trips = passenger.trips.order(:date)
    else
      @trips = Trip.order(:date)
      return
    end
  end
  
  def show
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end
  end
  
  def new
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
    else
      @trip = Trip.new
    end
  end
  
  def create
    driver = Driver.get_available_driver
    driver.toggle_available
    
    date = Date.today
    cost = rand(1000..9999)
    
    data_hash = 
    { driver_id: driver.id,
    passenger_id: params[:passenger_id],
    date: date,
    cost: cost }  
    
    @trip = Trip.new(data_hash)
    
    if @trip.save
      redirect_to passenger_path(params[:passenger_id])
      return
    else
      redirect_to passenger_path(params[:passenger_id])
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    end 
  end
  
  def update 
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      redirect_to root_path
      return
    elsif @trip.update(trip_params)
      # https://stackoverflow.com/questions/31978482/how-to-process-text-input-data-before-form-submit-ruby-on-rails
      @trip.cost = (trip_params[:cost].to_f * 100.0).round if params[:special_form].present?
      @trip.save
      redirect_to trip_path
      return
    else
      render :edit
      return
    end 
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id])
    
    @trip.destroy if @trip
    
    redirect_to root_path
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost, :driver_id, :passenger_id, :special_form)
  end
end
