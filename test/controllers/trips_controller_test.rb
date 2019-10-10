require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create name: "A Passenger", phone_num: "206-123-3333"
    @available_driver = Driver.create name: "Random Driver", vin: "XFHJKDHSLFKJDKL", available: true
  end
  describe "show" do
    it "must respond with success when showing a specific trip by its ID" do
      trip_parameters = Trip.create_new_trip
      trip = Trip.new(
        passenger_id: @passenger.id,
        date: trip_parameters[:date],
        cost: trip_parameters[:cost],
        driver_id: @available_driver.id,
      )

      trip.save

      get trips_path(trip.id)

      must_respond_with :success
    end

    it "must respond with a 404 for a non-existing trip" do
      invalid_trip_id = 12903

      get trip_path(invalid_trip_id)

      must_respond_with :not_found
    end
  end

  describe "create" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
    # Your tests go here
  end
end
