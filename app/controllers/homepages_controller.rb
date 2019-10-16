class HomepagesController < ApplicationController
  
  def index
    @drivers = Driver.all
    @passengers = Passenger.all
    @trips = Trip.all
  end
  
end
