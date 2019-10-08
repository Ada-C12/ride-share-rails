class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    #Handle Validation Errors
  end
  
  def new
  end
  
  def create
    #Handle Validation Errors
  end
end
