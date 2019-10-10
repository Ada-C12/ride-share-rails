require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) 
  }
  let (:passenger) {
    Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") 
  }
  
  let (:trip) {
    Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: "2016-04-05", rating: 3, cost: 1250 ) 
  }
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      test_driver = driver
      test_passenger = passenger
      test_trip = trip
      
      
      # Act
      get trip_path(test_trip.id)
      
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
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing trip saved
      test_trip = trip
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect{ delete trip_path(test_trip.id)}.must_differ "Trip.count", -1
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      
    end
    
    it "does not change the db when the trip does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no trip
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{ delete trip_path(-1)}.wont_change "Trip.count"
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
