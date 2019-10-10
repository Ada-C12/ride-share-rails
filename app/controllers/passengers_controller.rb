class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :edit, :update, :destroy]
  
  # GET /passengers
  # GET /passengers.json
  def index
    @passengers = Passenger.all
  end
  
  # GET /passengers/1
  # GET /passengers/1.json
  def show
  end
  
  # GET /passengers/new
  def new
    @passenger = Passenger.new
    
  end
  
  # GET /passengers/1/edit
  def edit
  end
  
  # POST /passengers
  # POST /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)
    
    respond_to do |format|
      if @passenger.save
        format.html { redirect_to @passenger, notice: 'Passenger was successfully created.' }
        format.json { render :show, status: :created, location: @passenger }
      else
        format.html { render :new }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /passengers/1
  # PATCH/PUT /passengers/1.json
  def update
    respond_to do |format|
      if @passenger.update(passenger_params)
        format.html { redirect_to @passenger, notice: 'Passenger was successfully updated.' }
        format.json { render :show, status: :ok, location: @passenger }
      else
        format.html { render :edit }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /passengers/1
  # DELETE /passengers/1.json
  def destroy
    @passenger.destroy
    respond_to do |format|
      format.html { redirect_to passengers_url, notice: 'Passenger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def create_new_trip
    @passenger = Passenger.find(params[:id])
    
    trip_info = {
      trip: {   
        driver_id: Driver.find_available_driver,
        passenger_id: @passenger.id,
        date: Time.now,
        rating: nil,
        cost: 100,}
      }
      new_trip = Trip.new(trip_info[:trip])
      # set the status of the driver as true 
      # then save the trip
      new_trip.save
      p new_trip.errors 
      
      if new_trip.save == true
        flash[:success] = "Trip successfully created." 
        new_trip.driver.active = false 
      else 
        flash[:error] = "Uh Oh! Something went wrong."
      end

      redirect_to passenger_path(@passenger)
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_passenger
    @passenger = Passenger.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def passenger_params
    params.require(:passenger).permit(:name, :phone_num)
  end
end