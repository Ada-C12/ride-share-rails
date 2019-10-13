require "test_helper"

describe TripsController do  
  let (:passenger) { 
    Passenger.create(name: "julia", phone_number: "555") 
  }

  let (:driver) { 
    Driver.create(name: "dani", vin: 2345) 
  }

  let (:trip) {
    Trip.create(passenger_id: passenger.id, driver_id: driver.id, rating: nil, cost: 1000, date: Time.now)
  }

  describe "show" do
    it "can get a valid trip" do
      # Act
      get trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      #Act
      get trip_path(-1)

      #Assert
      must_respond_with :redirect
    end
  end

  describe "create" do
    it "can create a new trip" do 
    passenger_id = passenger.id
    driver.save
  
    trip_hash= {
      trip:{
        passenger_id: passenger_id, 
        driver_id: nil,
        rating: nil,
        cost: nil,
        date: Time.now,
      }
    }
 
    expect {
    post passenger_trips_path(passenger_id), params: trip_hash
    }.must_differ "Trip.count", 1

    must_respond_with :redirect
    must_redirect_to  passenger_path(passenger_id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      # Act
      get edit_trip_path(trip.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      # Act
      get edit_trip_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update rating when trip has never been rated" do
    trip
    updated_trip = {
      trip: {
        rating: 5,
      },
    }
    # Act
      expect {
        put trip_path(trip.id), params: updated_trip 
      }.wont_change 'Trip.count'
    # Assert: 
      expect(Trip.find_by(id: trip.id).rating).must_equal 5
    end

    it "can update rating and cost of a trip" do
      trip2 = Trip.create(passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 1000, date: Time.now)
      updated_trip2 = {
        trip: {
        rating: 4,
        cost: 3000
        },
      }
      # Act
      expect {
        put trip_path(trip2.id), params: updated_trip2 
      }.wont_change 'Trip.count'
      # Assert: 
      expect(Trip.find_by(id: trip2.id).rating).must_equal 4
      expect(Trip.find_by(id: trip2.id).cost).must_equal 3000
    end

    it "will redirect to the root page if given an invalid id" do
      # Act
      put trip_path(-1)

      # Assert
      must_respond_with :redirect    
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
