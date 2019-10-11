require "test_helper"

describe TripsController do
  #Does each trip need me to create a new instance of driver and passenger?
  let (:trip) {
   Trip.create driver_id: , passenger_id: , date: Date.today}

  describe "show" do
    get trip_path
    must_respond_with :success
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
