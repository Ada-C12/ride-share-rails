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
      unavailable_driver = Driver.create(name: "I am unavailable", vin: "unavailable", active: false)
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9", active: true)
      driver_id = driver.id
      
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      passenger_id = passenger.id
      
      expect {post passenger_trips_path(passenger_id)}.must_change 'Trip.count', 1
      
      # Assert
      # Find the newly created Trip, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      
      new_trip = Trip.all.first
      expect(new_trip.rating).must_be_nil
      expect(new_trip.driver_id).must_equal driver_id
      expect(new_trip.passenger_id).must_equal passenger_id
      expect(new_trip.date).wont_be_nil
      expect(new_trip.cost).wont_be_nil
      expect(passenger.trips).must_include new_trip
      
      must_redirect_to passenger_path(new_trip.passenger_id)
    end
    
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9", active: true)
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      test_trip = Trip.create(date: DateTime.now, rating: 2, cost: 1000, driver_id: driver.id, passenger_id: passenger.id)
      
      get edit_trip_path(test_trip.id)
      
      must_respond_with :success      
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
      get edit_trip_path(-1)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    before do
      @driver = Driver.create(name: "test driver", vin: "test")
      @passenger = Passenger.create(name: "test person", phone_num: "1234567")
      time = DateTime.now
      tomorrow = DateTime.tomorrow
      @test_trip = Trip.create(date: time, rating: 2, cost: 1000, driver_id: @driver.id, passenger_id: @passenger.id)
      @new_driver = Driver.create(name: "new driver", vin: "new")
      @new_passenger = Passenger.create(name: "new", phone_num: "new")
      
      @trip_hash = {
        trip: {
          date: tomorrow,
          rating: 3, 
          cost: 111,
          driver_id: @new_driver.id,
          passenger_id: @new_passenger.id,
          driver_name: @new_driver.name,
          passenger_name: @new_passenger.name
        }
      }
    end
    
    it "can update an existing trip with valid information accurately, and redirect" do
      
      expect {patch trip_path(@test_trip.id), params: @trip_hash}.wont_change "Trip.count"
      new_trip = Trip.find_by(id: @test_trip.id)
      #date is not changeable
      expect(new_trip.date).must_equal @trip_hash[:trip][:date]
      expect(new_trip.rating).must_equal @trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal @trip_hash[:trip][:cost]
      expect(new_trip.driver_id).must_equal @trip_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal @trip_hash[:trip][:passenger_id]
      
      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
    
    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect{patch trip_path(-1)}.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
    
  end
  
  describe "rate" do
    it "responds with success when getting the rate page for an existing, valid trip" do
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9", active: true)
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      test_trip = Trip.create(date: DateTime.now, rating: 2, cost: 1000, driver_id: driver.id, passenger_id: passenger.id)
      
      get rate_path(test_trip.id)
      
      must_respond_with :success      
    end
    
    it "responds with redirect when getting the rate page for a non-existing trip" do
      get rate_path(-1)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      driver = Driver.create(name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9")
      passenger = Passenger.create(name: "test person", phone_num: "1234567")
      
      test_trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, cost: 500, date: DateTime.now, rating: nil)
      
      expect {delete trip_path(test_trip.id)}.must_change "Trip.count", -1
      
      new_trip = Trip.find_by(id: test_trip.id)
      expect(new_trip).must_be_nil
      
      must_redirect_to root_path
    end
    
    it "does not change the db when the trip does not exist, then responds with " do
      invalid_id = -1
      
      expect {delete trip_path(invalid_id)}.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
  end
end
