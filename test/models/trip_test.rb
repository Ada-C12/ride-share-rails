require "test_helper"

describe Trip do
  let (:driver) {
    Driver.create(name: "Spongebob Squarepants", vin: "ABCDER1234")
  }
  let (:passenger) {
    Passenger.create(name: "Patrick Star", phone_num: "123456789")
  }
  let (:trip) {
    Trip.new(date: Date.today, driver_id: driver.id, passenger_id: passenger.id)
  }

  it "can be instantiated" do
    # Your code here
    expect(trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Your code here
    trip.save
    first_trip = Trip.first
    [:date, :driver_id, :passenger_id].each do |field|
      expect(first_trip).must_respond_to field
    end
  end

  describe "relationships" do
    # Your tests go here
    it "it can have one driver" do
      trip.save
      first_trip = Trip.first
      expect(first_trip.driver).must_be_instance_of Driver
    end

    it "it can have on passenger " do
      trip.save
      first_trip = Trip.first
      expect(first_trip.passenger).must_be_instance_of Passenger
    end
  end

  describe "validations" do
    it "must have a date" do
      new_trip = Trip.create(date: "", driver_id: driver.id, passenger_id: passenger.id)
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a driver_id" do
      new_trip = Trip.create(date: Date.today, driver_id: "", passenger_id: passenger.id)
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :driver_id
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end

    it "must have a passenger_id" do
      new_trip = Trip.create(date: Date.today, driver_id: driver.id, passenger_id: "")
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end
  end
end
