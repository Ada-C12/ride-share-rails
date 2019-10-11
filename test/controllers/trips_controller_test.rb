require "test_helper"

describe TripsController do
  let (:driver) { Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) }
  let (:passenger) { Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") }
  let (:trip) { Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: "2016-04-05", rating: 3, cost: 1250 ) }
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      test_driver = driver
      test_passenger = passenger
      test_trip = trip
      
      # Act
      get trip_path(id: test_trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect if given invalid trip id" do
      # Arrange
      invalid_id = (-1)
      
      # Act
      get trip_path(invalid_id)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "create" do
    it "can create a new trip with a valid passenger, and redirect" do
      # Arrange
      driver.save
      passenger.save
      
      # Act-Assert
      expect { post passenger_trips_path(passenger.id)}.must_change "Trip.count", 1
      
      # Assert
      new_trip = Trip.first
      
      expect(new_trip.driver).must_be_instance_of Driver
      expect(new_trip.passenger).must_be_instance_of Passenger
      expect(new_trip.date).must_be_kind_of String
      expect(new_trip.cost).must_be_kind_of Integer
      assert_nil(new_trip.rating)
      
      must_respond_with :redirect
    end
    
    it "does not create a trip with invalid passenger, and responds with redirect" do
      # Arrange
      driver.save
      invalid_passenger_id = -1
      
      # Act-Assert
      expect { post passenger_trips_path(invalid_passenger_id) }.wont_change "Driver.count"
      
      # Assert
      must_respond_with :redirect
    end  
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      # Act
      get edit_trip_path(trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
      # Arrange
      invalid_id = -1
      
      # Act
      get edit_trip_path(invalid_id)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    # Your tests go here
  end
  
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      test_trip = trip
      
      # Act-Assert
      expect{ delete trip_path(test_trip.id)}.must_differ "Trip.count", -1
      
      # Assert
      must_respond_with :redirect
    end
    
    it "does not change the db when the trip does not exist, then responds with " do
      # Arrange
      invalid_id = -1
      
      # Act-Assert
      expect{ delete trip_path(-1)}.wont_change "Trip.count"
      
      # Assert
      must_respond_with :redirect
    end
  end
end
