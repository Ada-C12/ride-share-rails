require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) 
  }
  let (:passenger) {
    Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") 
  }
  
  let (:trip) {
    Trip.create(driver_id: 1, passenger_id: 1, date: "2016-04-05", rating: 3, cost: 1250 ) 
  }
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      test_driver = driver
      test_passenger = passenger
      test_trip = trip
      
      # Act
      get trip_path(trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid trip id" do
      # Arrange
      # Ensure that there is an id that points to no trip
      
      # Act
      get trip_path(-1)
      
      # Assert
      must_respond_with :not_found
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
