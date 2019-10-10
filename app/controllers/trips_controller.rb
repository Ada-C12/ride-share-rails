class TripsController < ApplicationController

        def index
            @trips = Trip.all
        end
    
        def show
            trip_id = params[:id].to_i
            @trip = Trip.find_by(id:trip_id)
    
            if  trip_id  < 0
                redirect_to root_path
            end
    
            if @trip.nil?
                redirect_to new_trip_path
            end
        
        end
    
        def new
            @trip = Trip.new
        end
    
        def create
            @trip = Trip.new(trip_params)
            if @trip.save
                redirect_to trip_path(@trip.id)
            else
                render new_trip_path
            end
        end
    
        def edit
            @trip = Trip.find_by(id: id)
            id = params[:id].to_i
        end
    
        def update
            id = params[:id].to_i
            if id < 0
                redirect_to root_path
            end

            # id,driver_id,passenger_id,date,rating,cost

            @trip = Trip.find_by(id: id)
            @trip[:name] = params[:trip][:name]
            @trip[:date] = params[:trip][:date]
            @trip[:rateing] = params[:trip][:rating]
            @trip[:cost] = params[:trip][:cost]
            if @trip.save
                redirect_to trip_path(@trip.id)
            else
                render new_trip_path
            end
        end
    
        def destroy
            trip_to_delete = Trip.find_by(id: params[:id])
            if trip_to_delete.nil?
                redirect_to trip_path
                return
            else
                trip_to_delete.destroy
                redirect_to trips_path
                return
            end
        end
    
        private
    
        def trip_params
            return params.require(:trip).permit(:date, :driver_id, :passenger_id, :rating, :cost)
        end
    
    
end
