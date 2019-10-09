require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      valid_trip = Trip.create(date: test_date, cost: 300, passenger_id: valid_passenger.id, driver_id: valid_driver.id)
      
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
      valid_trip = Trip.create(date: test_date, cost: 300, passenger_id: 1, driver_id: 1)
      # Act
      
      get trip_path("-1")
      
      # Assert
      must_respond_with :not_found
      
    end
  end
  
  describe "new" do
    it "responds with success" do
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      
      trip_hash = {trip: {date: test_date, cost: 400, driver_id: valid_driver.id, passenger_id: valid_passenger.id, rating: nil}}
      
      get new_trip_path(trip_hash)
      must_respond_with :success
    end
  end
  
  
  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      
      trip_hash = {trip: {date: test_date, cost: 400, driver_id: valid_driver.id, passenger_id: valid_passenger.id, rating: nil}}
      
      expect {post trips_path, params: trip_hash}.must_differ 'Trip.count', 1
      
      new_trip_id = Trip.find_by(date: test_date).id
      must_redirect_to trip_path(new_trip_id)
    end
    
    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Trip validations
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      invalid_trip_hash = {trip: {cost: 12.96, date: test_date, driver_id: valid_driver.id}}
      invalid_trip_hash_2 = {trip: {cost: 12.96, date: test_date, passenger_id: valid_passenger.id}}
      invalid_trip_hash_3 = {trip: {cost: 12.96, driver_id: valid_driver.id, passenger_id: valid_passenger.id}}
      invalid_trip_hash_4 = {trip: {date: test_date, driver_id: valid_driver.id, passenger_id: valid_passenger.id}}
      
      # Act-Assert
      # Ensure that there is no change in trip.count
      expect {post trips_path, params: invalid_trip_hash}.must_differ 'Trip.count', 0
      
      # Assert
      # Check that the controller redirects
      must_redirect_to new_trip_path
      
      expect {post trips_path, params: invalid_trip_hash_2}.must_differ 'Trip.count', 0
      must_redirect_to new_trip_path
      
      expect {post trips_path, params: invalid_trip_hash_3}.must_differ 'Trip.count', 0
      must_redirect_to new_trip_path
      
      expect {post trips_path, params: invalid_trip_hash_4}.must_differ 'Trip.count', 0
      must_redirect_to new_trip_path
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
