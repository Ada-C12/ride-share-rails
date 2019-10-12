require "test_helper"

describe TripsController do  
  let (:passenger) { 
    Passenger.create(name: "julia", phone_number: "555") 
  }

  let (:driver) { 
    Driver.create(name: "dani", vin: 2345) 
  }
  
  let (:trip) {
    Trip.create(passenger_id: passenger.id, driver_id: driver.id, rating: nil, cost: 1000, date: Time.now)
  }

  describe "show" do
    it "can get a valid trip" do
      # Act
      get trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      #Act
      get trip_path(-1)

      #Assert
      must_respond_with :redirect
    end
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
