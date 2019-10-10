require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create(
      name: "Jane",
      phone_num: "8675309"
    )

    @driver = Driver.create(
      name: "Sarah",
      vin: "848485859",
      car_make: "Ford",
      car_model: "Escape",
      active: true
    )

    @trip = Trip.create(
      date: "10-09-2019",
      rating: 3,
      cost: 20.40,
      passenger_id: @passenger.id,
      driver_id: @driver.id
    )
  end

  describe "show" do
    it "responds with success when showing an existing valid trip" do
      trip_id = @trip.id

      get trip_path(trip_id)

      must_respond_with :success
    end

    it "responds with a 404 with an invalid trip id" do
      get trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      Trip.destroy_all

      trip_hash = {
        trip: {
          date: "10-11-2019",
          rating: 3,
          cost: 10.40,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }

      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      must_respond_with :redirect
      must_redirect_to trip_path(Trip.first.id)
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      invalid_trip_hashes = [
        {
          trip: {
            date: "",
            rating: 7,
            cost: 10.40,
            passenger_id: @passenger.id,
            driver_id: @driver.id
          },
        },
        {
          trip: {
            date: "10-04-2019",
            rating: 7,
            cost: 10.40,
            passenger_id: @passenger.id,
            driver_id: nil
          },
        },
        {
          trip: {
            date: nil,
            rating: nil,
            cost: nil,
            passenger_id: @passenger.id,
            driver_id: nil
          },
        },
        {
          trip: {
            passenger_id: @passenger.id,
            driver_id: @driver.id
          },
        }
      ]

      invalid_trip_hashes.each do |trip_data|
        expect {
          post trips_path, params: trip_data
        }.must_differ "Trip.count", 0
      end

      must_respond_with :not_found
      # must_redirect_to new_passenger_trip_path(@passenger.id)
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

  # do we want/need index test?
end
