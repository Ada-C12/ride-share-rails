require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "jhgsdf", vin: 14353)
  }
  
  
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "333333333")
  }
  
  let (:trip) {
    Trip.create(date: Date.today, rating: 4, cost: 533, passenger: passenger, driver: driver)
  }
  
  
  describe "show" do
    it "can get a valid trip" do
      # Act
      get trips_path(trip.id)
      # Assert
      must_respond_with :success
    end
    it "will redirect for an invalid trip" do
      # Act
      get trip_path(-1)
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "create" do
    # Your tests go here
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      trip_hash= {
        trip:{
          date: Date.today,
          rating: 4,
          cost: 54, 
          passenger_id: 3
        }
      }
      trip_count = Trip.count
      expect {
        post trips_path, params: trip_hash
      }.must_differ "Trip.count", 1
      # expect(Trip.count).must_equal(trips_count + 1 )
      
      must_respond_with :redirect
      must_redirect_to  trips_path
    end
  end
  
  describe "edit" do
    # Your tests go here
    it "edit the trip data" do
      # skip
      get edit_trip_path(trip.id)
      # Assert
      must_respond_with :success
      
    end
    it "will respond with redirect when edit a nonexistant trip" do
      # Your code here
      invalid_id = -1
      get edit_trip_path(invalid_id)
      
      must_redirect_to trip_path
    end
  end
  
  describe "update" do
    # Your tests go here
    it "updated the " do
    end
  end
  
  describe "destroy" do
    # Your tests go here
    
    
  end
end
