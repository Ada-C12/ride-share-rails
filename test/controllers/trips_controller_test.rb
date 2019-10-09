require "test_helper"

describe TripsController do
  before do
    passenger = Passenger.create(
      name: "Jane",
      phone_num: "8675309"
    )

    driver = Driver.create(
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
      passenger_id: passenger.id,
      driver_id: driver.id
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
