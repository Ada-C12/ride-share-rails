require "test_helper"

describe TripsController do
  describe "index" do
    it "can get the index path" do
      get trips_path
      
      must_respond_with :success
    end
  end
  
  # *****LOOK******
  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid trip" do
      # # Act
      # get trip_path(trip.id)
      # # Assert
      # must_respond_with :success
      
    end
    
    it "will redirect with an invalid trip id" do
      # id = -1
      # # Act
      # get trip_path(id)
      # # Assert
      # must_respond_with :redirect
    end
  end
  
  # ADDED TEST
  describe "new" do
    # Your tests go here
    it "responds with success" do
      # get new_trip_path
      # must_respond_with :success
    end
  end
  
  describe "create" do
    # Your tests go here
    it "can create a new trip with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      trip_hash = {
        trip: {
          date: 2019-10-10,
          driver_id: 12,
          passenger_id: 11,
          cost: 123.0,
          rating: 4.0
        },
      }
      # Act-Assert
      # Ensure that there is a change of 1 in trip.count
      # expect {
      #   post trips_path, params: trip_hash
      # }.must_differ "trip.count", 1
      # Assert
      # Find the newly created trip, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      # new_trip = Trip.find_by(date: trip_hash[:trip][:date])
      # expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
      # expect(new_trip.driver_id).must_equal trip_hash[:trip][:passenger_id]
      # expect(new_trip.driver_id).must_equal trip_hash[:trip][:cost]
      # expect(new_trip.driver_id).must_equal trip_hash[:trip][:rating]
      
      # must_respond_with :redirect
      # must_redirect_to trip_path(new_trip.id)
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
