require "test_helper"

describe TripsController do
  let (:passenger_test) {
    Passenger.create(name: "Test Passenger!", phone_num: "555-555-5555")
  }
  let (:driver_test) {
    Driver.create(name: "Test Driver!", vin: "FSD34534SLDK", available: true)
  }
  let (:trip) {
    Trip.create(date: Date.today, rating: 5, cost: 1050, passenger_id: passenger_test.id, driver_id: driver_test.id)
  }

  describe "show" do
    it "can get a valid trip" do
      # Act
      get trip_path(trip.id)

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
    let (:passenger_test_2) {
      Passenger.create(name: "Test Passenger!", phone_num: "555-555-5555")
    }
    let (:driver_test_2) {
      Driver.create(name: "Test Driver!", vin: "FSD34534SLDK", available: true)
    }
    let (:trip) {
      Trip.create(date: Date.today, rating: nil, cost: 1000, passenger_id: passenger_test_2, driver_id: driver_test_2)
    }

    it "can create a new trip" do
      # Arrange


      trip_hash = {
          date: Date.today,
          rating: nil,
          cost: 1000,
          driver_id: driver_test_2,
          passenger_id: passenger_test_2
        }

      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(id: trip_hash.passenger_id)
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      get edit_trip_path(trip.id)

      # Assert
      must_respond_with :success
      
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      # Your code here
      invalid_id = -500

      get edit_trip_path(invalid_id)
      
      must_redirect_to trip_path
    end
  end

  describe "update" do
    # Your tests go here
    it "updates an existing trips successfully and reloads page" do
      input_trip = Trip.create(date: Date.today, rating: nil, cost: 1000, driver_id: 3, passenger_id: 5)
      input_updates = {trip: {rating: 5}}

      patch trip_path(input_trip), params: input_updates

      input_trip.reload
      expect(input_trip.rating).must_equal 5
    end
  end

  describe "destroy" do
    # Your tests go here

    # need to add passengers/drivers? getting caught in the trips show view
    it "successfully deletes an existing trip and then redirects to list of trips at trips index" do
      existing_trip = Trip.create(date: Date.today, rating: nil, cost: 1000, trip_id: 3, passenger_id: 5)
      existing_trip_id = Trip.find_by(id: existing_trip[:trip][:id]).id

      expect {
        delete trip_path( existing_trip_id )
      }.must_differ "trip.count", -1

      must_redirect_to trips_path
    end
  end
end
