require "test_helper"

describe TripsController do
  describe "show" do
    it "must respond with success when showing a specific trip by its ID" do
      trip = Trip.create date: Date.today, rating: 5, cost: 2300, driver_id: 1, passenger_id: 5

      get trip_path(trip.id)

      must_respond_with :success
    end

    it "must respond with a 404 for a non-existing trip" do
      invalid_trip_id = 12903

      get trip_path(invalid_trip_id)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip with valid information and redirects" do
      trip_parameters = Trip.create_new_trip
      trip_hash = {
        trip: {
          passenger_id: params[:passenger_id],
          date: trip_parameters[:date],
          cost: trip_parameters[:cost],
          driver_id: trip_parameters[:driver_id],
        },
      }

      expect {
        post passenger_trips_path, params: trip_hash
      }.must_change "Trip.count", 1
    end
  end

  describe "edit" do
    before do
      @trip = Trip.create date: Date.today, rating: 5, cost: 2300, driver_id: 1, passenger_id: 5
    end
    it "responds with success when getting the edit page of an existing trip" do
      get edit_trip_path(@trip.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      get edit_trip_path(-1)

      must_respond_with :redirect
      must_redirect_to passenger_path(@trip.passenger.id)
    end
  end

  describe "update" do
    it "can update an existing trip with valid information accurately, and redirect" do
      existing_trip = Trip.create date: Date.today, rating: 3, cost: 1240, driver_id: 8, passenger_id: 15

      updated_trip_hash = {
        trip: {
          rating: 5,
        },
      }

      expect {
        patch trip_path(existing_trip.id), params: updated_trip_hash
      }.wont_change "Trip.count"

      updated_trip = Trip.find_by(id: existing_trip.id)

      expect(updated_trip.rating).must_equal updated_trip_hash[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to passenger_path(updated_trip.passenger.id)
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
