class DriversController < ApplicationController

    def index
        @drivers = Driver.all.order(:id)
        end

    def show
        driver_id = params[:id].to_i
        @driver = Driver.find_by(id:driver)
    
    end

    def new
    end

    def edit
    end


end
