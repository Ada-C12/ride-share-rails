require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "sample driver", vin: "a sample vin")
  }
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "sample number")
  }
  let (:trip) {
    Trip.create date: Date.today, rating: 4, cost: 23.00, driver: driver, passenger: passenger
  }
  describe "show" do
    it "can get a valid trip" do
      get trip_path(trip.id)
      
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip" do
      get trip_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  describe "create" do
    it "" do
      # Your tests go here
    end
  end
  
  describe "edit" do
    it "" do
      # Your tests go here
    end
  end
  
  describe "update" do
    it "" do
      # Your tests go here
    end
  end
  
  describe "destroy" do
    it "" do
      # Your tests go here
    end
  end
end
