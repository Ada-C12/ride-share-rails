class DriversController < ApplicationController

    def index
        @drivers = Driver.all
    end

    def show
        driver_id = params[:id].to_i
        @driver = Driver.find_by(id:driver_id)
    
    end

    def new
        @driver = Driver.new
    end

    def edit
    end


end
