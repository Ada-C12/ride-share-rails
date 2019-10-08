class HomepagesController < ApplicationController
  def index
    @passengers = Passenger.all
    @drivers = Driver.all
  end
end
