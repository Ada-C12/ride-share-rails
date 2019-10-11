require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 4,
          cost: 100,
        },
      }
    end

    it "can delete a trip" do
      old_trip = Trip.create(@trip_info[:trip])
      expect {
        delete trip_path(old_trip.id)
      }.must_change "Trip.count", 1
    end

    it "will respond with not_found if given an invalid id" do
      patch trip_path(-1)
      must_respond_with :not_found
    end
  end
end
