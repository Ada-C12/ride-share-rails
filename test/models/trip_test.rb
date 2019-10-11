require "test_helper"

describe Trip do
  let (:passenger_test) {
    Passenger.create(name: "Test Passenger!", phone_num: "555-555-5555")
  }
  let (:driver_test) {
    Driver.create(name: "Test Driver!", vin: "FSD34534SLDK", available: true)
  }
  let (:new_trip) {
    Trip.create(date: Date.today, rating: 5, cost: 1050, passenger_id: passenger_test.id, driver_id: driver_test.id)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:date, :rating, :cost, :passenger_id, :driver_id].each do |field|

    # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can has a passenger id and driver id" do
      new_trip.save

      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      new_passenger = 
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      # Assert
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
end