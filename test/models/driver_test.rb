require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :active].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)

      # Assert
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      
      it "successfully calculates and returns the average rating" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
        first_trip = Trip.create(cost: 12.46, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 5)
        second_trip = Trip.create(cost: 13.50, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 3)

        expect(current_driver.average_rating).must_equal 4

      end

      it "returns nil if the driver has not received any ratings" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
        first_trip = Trip.create(cost: 12.46, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id)
        second_trip = Trip.create(cost: 13.50, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id)
        
        expect(current_driver.average_rating).must_be_nil
      end
    end

    describe "total earnings" do
      
      it "accurately calculates a driver's total earnings" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
        first_trip = Trip.create(cost: 12.46, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 5)
        second_trip = Trip.create(cost: 13.50, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 3)

        expect(current_driver.total_earnings).must_equal 18.128
      end

      it "returns 0 if the driver has not made any trips" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        expect(current_driver.total_earnings).must_equal 0
      end

      it "returns 0 if the driver did not make any money" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
        first_trip = Trip.create(cost: 1.35, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 5)
        second_trip = Trip.create(cost: 0.80, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 3)

        expect(current_driver.total_earnings).must_equal 0
      end
    end

    describe "count" do
      it "accurately calculates the driver's number of trips" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
        first_trip = Trip.create(cost: 12.46, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 5)
        second_trip = Trip.create(cost: 13.50, date: Date.today, driver_id: current_driver.id, passenger_id: passenger_id, rating: 3)

        expect(current_driver.trip_count).must_equal 2
      end

      it "returns 0 if the driver has not made any trips" do
        current_driver = Driver.create(name: "Jane Doe", vin: "12345678")
        expect(current_driver.trip_count).must_equal 0
      end
    end

    describe "can go online" do
      # Your code here
    end

    describe "can go offline" do
      # Your code here
    end

    # You may have additional methods to test
    describe "find_available_driver" do
      it "successfully returns the id of an available driver" do
        driver_1 = Driver.create(name: "Jane Doe", vin: "1234567", active: true)
        driver_2 = Driver.create(name: "John Deere", vin: "7654321", active: false)

        expect(Driver.find_available_driver).must_equal driver_2.id
      end

      it "returns nil if no drivers are available or no drivers exist" do
        expect(Driver.find_available_driver).must_be_nil

        driver_1 = Driver.create(name: "Jane Doe", vin: "1234567", active: true)
        driver_2 = Driver.create(name: "John Deere", vin: "7654321", active: true)

        expect(Driver.find_available_driver).must_be_nil
      end

    end
  end
end