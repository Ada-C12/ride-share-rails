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
    # Your code here
  end
  
  it "will have the required fields" do
    # Your code here
  end
  
  describe "relationships" do
    it "has relationships to driver and passenger" do
      expect(trip.driver).must_be_instance_of Driver
      expect(trip.passenger).must_be_instance_of Passenger
    end
  end
  
  describe "validations" do
    it "won't create a trip if driver or passenger are invalid" do
      invalid_trip = Trip.create(date: Date.today, rating: 4, cost: 2300, driver_id: nil, passenger_id: nil)
      expect(invalid_trip.id).must_be_nil
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
