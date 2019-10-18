require "test_helper"

describe Trip do
  let (:driver) {
    Driver.create(name: "sample driver", vin: "a sample vin", active: false)
  }
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "sample number")
  }
  let (:trip) {
    Trip.create(date: Date.today, rating: 4, cost: 2300, driver_id: driver.id, passenger_id: passenger.id)
  }
  it "can be instantiated" do
    expect(trip.valid?).must_equal true
    expect(trip).must_be_instance_of Trip
    expect(trip).wont_be_nil
  end
  
  it "will have the required fields" do
    expect(trip.date).wont_be_nil
    expect(trip.rating).wont_be_nil
    expect(trip.cost).wont_be_nil
    expect(trip.driver_id).wont_be_nil
    expect(trip.passenger_id).wont_be_nil

    [:date, :rating, :cost, :driver_id, :passenger_id].each do |field|
      expect(trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "has relationships to driver and passenger" do
      expect(trip.driver).must_be_instance_of Driver
      expect(trip.passenger).must_be_instance_of Passenger
    end
  end
  
  describe "validations" do
    it "must have a driver" do
      invalid_trip = Trip.create(date: Date.today, rating: 4, cost: 2300, driver_id: nil, passenger_id: passenger.id)
      expect(invalid_trip.id).must_be_nil
      expect(invalid_trip.valid?).must_equal false
    end

    it "must have a passenger" do
      invalid_trip = Trip.create(date: Date.today, rating: 4, cost: 2300, driver_id: driver.id, passenger_id: nil)
      expect(invalid_trip.id).must_be_nil
      expect(invalid_trip.valid?).must_equal false
    end
  end
end
