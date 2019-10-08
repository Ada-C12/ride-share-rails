require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      
      valid_trip = Trip.create(date: test_date, cost: 300, rating: nil, passenger_id: valid_passenger.id, driver_id: valid_driver.id)
      
      # Act
      get trip_path(valid_trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid trip id" do
      # Arrange
      # Ensure that there is an id that points to no trip
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      valid_trip = Trip.create(date: test_date, cost: 300, rating: nil, passenger_id: 1, driver_id: 1)
      # Act
      
      get trip_path("-1")
      
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
