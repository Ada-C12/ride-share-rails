require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|

      # Assert
      expect(passenger).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      new_passenger.save
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      ​
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
      
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    let (:driver) {
      Driver.create(name: "Driver", vin: "123", active: nil)
    }

    let(:passenger) {
      Passenger.create(name: "Haha Me", phone_num: "Nonono")
    }

    let(:trip_1) {
      Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "1000", rating: "5")
    }

    let(:trip_2) {
      Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "2000", rating: "4")
    }

    describe "request a ride" do
      # Your code here
      it "will return a hash with all required information to create a trip when passenger request a trip" do
        driver.save
        trip_hash = passenger.request_a_ride

        expect(trip_hash).must_be_instance_of Hash
        expect(trip_hash[:passenger_id]).must_equal passenger.id
        expect(trip_hash[:driver_id]).must_equal driver.id
        expect(trip_hash[:date]).must_be_instance_of Date
      end
    end

    describe "total charge" do
      # Your code here
      it "can calculate the total expense of this passenger when the passenger took at least one trip" do
        driver.save
        passenger.save
        total_expense = (trip_1.cost.to_i + trip_2.cost.to_i)

        expect(passenger.total_charge).must_equal total_expense
      end

      it "will return 0 if the driver did not take any trip" do
        driver.save
        passenger.save
        Trip.destroy_all

        expect(passenger.total_charge).must_equal 0
      end
    end

    describe "complete trip" do
      # Your code here
      it "changes the driver active status to true after clicking submit botton for rating and cost which means that the driver is available to accept a trip" do
        passenger.save
        trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today)
        driver.go_online

        passenger.complete_trip(trip.id)
        expect(Driver.find(driver.id).active).must_be_nil
      end
    end
  end
end
