class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all
  end
  
  def new
    @driver = Driver.new()
  end
  
  def create
  end
  
end
