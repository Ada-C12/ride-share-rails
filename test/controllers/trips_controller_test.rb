require "test_helper"

describe TripsController do
  #Does each trip need me to create a new instance of driver and passenger?
  let (:passenger) {
    Passenger.create name: "Mr. Jared", phone_num: "954-666-6666"
  }

  let (:driver) {
    Driver.create name: "Mx. Dee", vin: "56R7FGYHFS"
  }

  let (:trip) {
   Trip.create driver_id: driver.id, passenger_id: passenger.id, date: Date.today}

  describe "show" do
    it "shows a list of all a passengers trip" do 
      get passenger_trip_path
      must_respond_with :success
    end 
  end

  describe "create" do
    it "successfully creates a new instance of a trip for a passenger" do
      
      trip_hash = {
        trip: {
          driver_id: driver_id,
          passenger_id: passenger_id,
          date: Date.today,
        }
      }
      
      expect {post new_passenger_trip_path params: trip_hash}.must_change "Passenger.trips.count", 1

    end 
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
