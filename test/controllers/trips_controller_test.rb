require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid trip" do
      # Ensure that there is a trip saved
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      trip = Trip.create(date: DateTime.now, rating: 2, cost: 1000, driver_id: driver.id, passenger_id: passenger.id)
      
      # Act
      get trip_path(trip.id)
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid trip id" do
      # Act
      get trip_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      
      # Set up the form data
      data_hash = {
        trip: {
          date: DateTime.now,
          rating: 2,
          cost: 1000,
          driver_id: driver.id,
          passenger_id: passenger.id,
        }
      }
      
      # Act-Assert
      # Ensure that there is a change of 1 in Trip.count
      expect {
        post trips_path, params: data_hash
      }.must_change 'Trip.count', 1
      
      # Assert
      # Find the newly created Trip, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      
      new_trip = Trip.first
      expect(new_trip.rating).must_equal data_hash[:trip][:rating]
      expect(new_trip.cost).must_equal data_hash[:trip][:cost]
      expect(new_trip.driver_id).must_equal data_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal data_hash[:trip][:passenger_id]
      
      must_redirect_to passenger_path(new_trip.passenger_id)
    end
    
    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Trip validations
      data_hash = {}
      
      # Act-Assert
      # Ensure that there is no change in Trip.count
      expect {
        post trips_path, params: data_hash
      }.wont_change 'Trip.count'
      
      # Assert
      # Check that the controller redirects
      must_redirect_to root_path
    end
  end
  
  describe "edit" do
    # Your tests go here
  end
  
  describe "update" do
    # Your tests go here
  end
  
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      
      test_trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, cost: nil, date: DateTime.now, rating: nil)
      
      expect {
        delete trip_path(test_trip.id)
      }.must_change "Trip.count", -1
      
      new_trip = Trip.find_by(id: test_trip.id)
      expect(new_trip).must_be_nil
      
      must_redirect_to root_path
    end
    
    it "does not change the db when the trip does not exist, then responds with " do
      invalid_id = -1
      
      expect {
        delete trip_path(invalid_id)
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
  end
end
