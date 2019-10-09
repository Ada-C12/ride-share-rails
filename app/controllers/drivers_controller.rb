class DriversController < ApplicationController
  def index
    @drivers = Driver.all_by_id_desc
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
  end
end
