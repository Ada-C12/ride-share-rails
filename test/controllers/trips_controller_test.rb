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
      cost: 2040,
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
          cost: 1040,
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
            cost: 1040,
            passenger_id: @passenger.id,
            driver_id: @driver.id
          },
        },
        {
          trip: {
            date: "10-04-2019",
            rating: 7,
            cost: 1040,
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

      # Test that edit page will render, per Jared's slack msg
      must_respond_with :success
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      get edit_trip_path(@trip.id)

      must_respond_with :success
    end

    it "will respond with a redirect if attempting to edit a trip that does not exist" do
      get edit_trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      @updated_trip_data = {
        trip: {
          date: "12-09-2019",
          rating: 4,
          cost: 4340,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }
    end

    it "can update an existing trip with valid information accurately, and redirect" do
      trip = Trip.create(
        date: "12-09-2019",
        rating: 5,
        cost: 4540,
        passenger_id: @passenger.id,
        driver_id: @driver.id
      )

      trip_id = trip.id

      expect {
        patch trip_path(trip_id), params: @updated_trip_data
      }.must_differ "Trip.count", 0

      expect(Trip.find_by(id: trip_id).rating).must_equal @updated_trip_data[:trip][:rating]
      expect(Trip.find_by(id: trip_id).cost).must_equal @updated_trip_data[:trip][:cost]
      must_respond_with :redirect
      must_redirect_to trip_path(trip_id)
    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect {
        patch trip_path(-1), params: @updated_trip_data
      }.must_differ "Trip.count", 0

      must_respond_with :not_found
    end

    it "does not update any trip if the form data violates Trip validations, and responds with a render of the edit page" do
      trip_id = @trip.id
      
      invalid_trip_data = {
        trip: {
          date: "",
          rating: 4,
          cost: 4340,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }

      expect {
        patch trip_path(trip_id), params: invalid_trip_data
      }.must_differ "Trip.count", 0

      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the trip instance in the db when the trip exists, and redirects" do
      trip = Trip.first
      trip_id = trip.id
      expect(Trip.count).must_be :>, 0

      expect {
        delete trip_path(trip_id)
      }.must_differ "Trip.count", -1

      assert_nil (Trip.find_by(id: trip_id))
      must_respond_with :redirect
      must_redirect_to root_path
    end 

    it "does not change the db when the trip does not exist, then responds with a 404" do
      invalid_id = -1
      expect(Trip.count).must_be :>, 0
      assert_nil (Trip.find_by(id: invalid_id))

      expect {
        delete trip_path(invalid_id)
      }.must_differ "Trip.count", 0

      must_respond_with :not_found
    end


  end

end
