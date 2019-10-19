require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create name: "sample driver", vin: "VH1234SD234F0909", active: true, car_make: "Fiat", car_model: "POP"
  }
  let (:passenger) {
    Passenger.create name: "Jon Snow", phone_num: "123.345.6789"
  }
  let (:trip) {
    Trip.create date: 2019 - 10 - 10, driver_id: driver.id, passenger_id: passenger.id, cost: 123.0, rating: 4.0
  }

  describe "index" do
    it "can get the index path" do
      get trips_path

      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid trip" do
      # # Act
      get trip_path(trip.id)
      # # Assert
      must_respond_with :success
    end

    it "will redirect with an invalid trip id" do
      id = -1
      # # Act
      get trip_path(id)
      # # Assert
      must_respond_with :redirect
    end
  end

  describe "create" do
    # it "can create a new trip with valid information accurately, and redirect" do
    #   # Arrange
    #   # Set up the form data
    #   driver = Driver.create(name: "sample driver", vin: "VH1234SD234F0909", active: false, car_make: "Fiat", car_model: "POP")
    #   passenger = Passenger.create(name: "Jon Snow", phone_num: "123.345.6789")
    #   trip_hash = {
    #     trip: {
    #       date: Date.today,
    #       driver_id: driver.id,
    #       passenger_id: passenger.id,
    #       cost: 123.0,
    #       rating: 4.0,
    #     },
    #   }

    #   # Act-Assert
    #   # Ensure that there is a change of 1 in trip.count
    #   expect {
    #     post trips_path(trip.id)
    #   }.must_differ "Trip.count", 1

    #   expect {
    #     delete passenger_path(invalid_passenger_id)
    #   }.must_differ "Passenger.count", 0
    #   # Assert
    #   # Find the newly created trip, and check that all its attributes match what was given in the form data
    #   # Check that the controller redirected the user
    #   new_trip = Trip.find_by(date: trip_hash[:trip][:date])
    #   expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
    #   expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]
    #   expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
    #   expect(new_trip.rating).must_equal trip_hash[:trip][:rating]

    #   must_respond_with :redirect
    # end
  end
  describe "edit" do
    # Your tests go here
    it "will be a successful response" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end
  end

  describe "update" do
    before do
      let (:trip) {
        Trip.create date: Date.today, driver_id: driver.id, passenger_id: passenger.id, cost: 123.0, rating: 4.0
      }
    end
    driver_hash = {
      driver: {
        id: 1,
        name: "new driver",
        vin: "VH1234SD234F0909",
        active: true,
        car_make: "Toyota",
        car_model: "Sedan",
      },
    }
    passenger_hash = {
      passenger: {
        name: "",
        id: 3,
        phone_num: "234.456.2345",
      },
    }
    trip_hash = {
      trip: {
        date: Date.today,
        driver_id: driver_hash[:driver][:id],
        passenger_id: passenger_hash[:passenger][:id],
        cost: 3.0,
        rating: 5.0,
      },
    }
  end

  describe "destroy" do
    # Your tests go here
    # it "destroys all trips then redirects" do
    #   driver = Driver.create(name: "sample driver", vin: "VH1234SD234F0909", active: false, car_make: "Fiat", car_model: "POP")
    #   passenger = Passenger.create(name: "Jon Snow", phone_num: "123.345.6789")
    #   trip = Trip.create(date: Date.today, driver_id: driver.id, passenger_id: passenger.id, cost: 123.0, rating: 4.0)
    #   trip_id = trip.id
    #   #Trip.destroy_all

    #   expect {
    #     delete trips_path(trip_id)
    #   }.must_differ "Trip.count", -1

    #   must_redirect_to trips_path
    # end
  end
end
