require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true,
               car_make: "Cherry", car_model: "DR5")
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :active, :car_make, :car_model].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      driver = Driver.first

      # Assert
      expect(driver.trips.count).must_be :>=, 0
      driver.trips.each do |trip|
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
      it "returns nil if the driver has no rides" do
        new_driver.update(active: false)
        expect(new_driver.average_rating).must_be_nil
      end
      it "can return the average rating of a driver's trips in the form of a float" do
        new_driver.update(active: false)
        passenger = Passenger.create(name: "Mac Do", phone_num: "253.394.8901")
        trip = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, rating: 5, cost: 1000.00, date: Date.new(2019, 3, 4))
        passenger2 = Passenger.create(name: "Do li", phone_num: "253.867.5309")
        trip2 = Trip.create(driver_id: new_driver.id, passenger_id: passenger2.id, rating: 4, cost: 1000.00, date: Date.new(2019, 4, 4))

        expect(new_driver.average_rating).must_equal 4.5
        expect(new_driver.average_rating).must_be_instance_of Float
      end
    end

    describe "total earnings" do
      it "must return the total cost of the driver's trips" do
        new_driver.update(active: false)
        passenger = Passenger.create(name: "Mac Do", phone_num: "253.394.8901")
        trip = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, rating: 5, cost: 1000.00, date: Date.new(2019, 3, 4))
        passenger2 = Passenger.create(name: "Do li", phone_num: "253.867.5309")
        trip2 = Trip.create(driver_id: new_driver.id, passenger_id: passenger2.id, rating: 4, cost: 1000.00, date: Date.new(2019, 4, 4))

        expect(new_driver.total_earnings).must_equal 1597.36
      end
      it "must return a float" do
        new_driver.update(active: false)
        passenger = Passenger.create(name: "Mac Do", phone_num: "253.394.8901")
        trip = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, rating: 5, cost: 1000.00, date: Date.new(2019, 3, 4))
        passenger2 = Passenger.create(name: "Do li", phone_num: "253.867.5309")
        trip2 = Trip.create(driver_id: new_driver.id, passenger_id: passenger2.id, rating: 4, cost: 1000.00, date: Date.new(2019, 4, 4))

        expect(new_driver.total_earnings).must_be_instance_of Float
      end
    end

    describe "toggle_active" do
      it "can toggle the active status of a driver when a ride is requested" do
        new_driver.update(active: false)
        passenger = Passenger.create(name: "Mac Do", phone_num: "253.394.8901")
        trip = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, rating: 5, cost: 1000.00, date: Date.new(2019, 3, 4))
        expect(new_driver.toggle_active).must_equal true
      end
    end

    describe "can go offline" do
      # Your code here
    end

    # You may have additional methods to test
  end
end
