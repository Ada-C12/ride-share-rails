class DriversController < ApplicationController
  def index
    @drivers = Driver.alpha_drivers
  end
end
