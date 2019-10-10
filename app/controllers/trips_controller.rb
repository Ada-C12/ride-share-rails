class TripsController < ApplicationController
  def index

  end 
  
  def show
    @trip = Trip.find_by(id: params[:id])
  end
end

