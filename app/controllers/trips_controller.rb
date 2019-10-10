class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:id)
  end

  def show
    trip_id = params[:id].to_i
    @trip = Trip.find_by(id:trip_id)
    if @trip.nil?
      redirect_to trips_path
      return
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
      redirect_to trip_path(@trip.id)

    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    if !@trip
      redirect_to trips_path
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if !@trip
      redirect_to trips_path
      return
    end
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
    else
      render new_trip_path
    end
  end

  def destroy
    trip_to_delete = Trip.find_by(id: params[:id])
    if trip_to_delete.nil?
      redirect_to trips_path
      return
    else
      trip_to_delete.destroy
      redirect_to trips_path
      return
    end
  end

  # def completed
  #   completed_task = Task.find_by(id: params[:id])
  #   if completed_task.nil?
  #     redirect_to task_path
  #     return
  #   end
  #   if completed_task.completed == nil
  #     completed_task.completed = Date.today
  #     completed_task.save
  #     redirect_to tasks_path
  #   else
  #     completed_task.completed = nil
  #     completed_task.save
  #     redirect_to tasks_path
  #   end
  # end

  private

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :cost, :rating)
  end
end
