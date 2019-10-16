require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create name: "A Passenger", phone_num: "206-123-3333"
    @available_driver = Driver.create name: "Random Driver", vin: "XFHJKDHSLFKJDKL", available: true
    @trip = Trip.new(
      passenger_id: @passenger.id,
      date: Date.today,
      cost: 1000,
      driver_id: @available_driver.id,
    )
  end
  describe "show" do
    it "must respond with success when showing a specific trip by its ID" do
      @trip.save

      get trip_path(@trip.id)

      must_respond_with :success
    end

    it "must respond with a 404 for a non-existing trip" do
      invalid_trip_id = 12903

      get trip_path(invalid_trip_id)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip with valid inputs" do
      new_trip_hash = {
        trip: {
          passenger_id: @passenger.id,
          date: Date.today,
          cost: 1500,
          driver_id: @available_driver.id,
        },
      }

      expect {
        post passenger_trips_path(@passenger.id), params: new_trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find(Trip.last.id)

      expect(new_trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      @trip.save

      get edit_trip_path(@trip.id)

      must_respond_with :success
    end

    it "it will respond with a redirect when attempting to edit a non-existing trip" do
      invalid_trip_id = -1

      get edit_trip_path(invalid_trip_id)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    it "can update an existing trip" do
      updated_trip = {
        trip: {
          passenger_id: @passenger.id,
          date: Date.today,
          cost: 2000,
          driver_id: @available_driver.id,
        },
      }

      @trip.save

      trip_id = @trip.id
      patch trip_path(trip_id), params: updated_trip

      edited_trip = Trip.find_by(id: trip_id)
      expect(edited_trip.passenger_id).must_equal updated_trip[:trip][:passenger_id]
      expect(edited_trip.cost).must_equal updated_trip[:trip][:cost]
    end

    it "will redirect to the list of trips if given an invalid ID" do
      # Your code here
      invalid_trip_id = -1
      patch trip_path(invalid_trip_id), params: @updated_trip

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    before do
      @trip_to_be_deleted = Trip.create!(passenger_id: @passenger.id, date: Date.today, cost: 3000, driver_id: @available_driver.id)
    end
    it "can delete an existing trip" do
      expect {
        delete trip_path(@trip_to_be_deleted.id)
      }.must_change "Trip.count", 1

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "must respond with 'not found' if given an invalid ID" do
      invalid_trip_id = 23152

      delete trip_path(invalid_trip_id)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "won't change the driver and passenger count when a trip is destroyed" do
      expect {
        delete trip_path(@trip_to_be_deleted.id)
      }.wont_change "Driver.count"
    end
  end
end
