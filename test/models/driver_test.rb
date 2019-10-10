require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123")
  }

  it "can be instantiated" do
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|

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
    let (:new_passenger) {
      Passenger.new(name: "Chris", phone_num: "123-333-3333")
    }

    before do
      new_passenger.save
      new_driver.save
      @trip1 = Trip.create(
        passenger_id: new_passenger.id,
        date: Date.today,
        cost: 10.00,
        rating: 5,
        driver_id: new_driver.id,
      )

      @trip2 = Trip.create(
        passenger_id: new_passenger.id,
        date: Date.today,
        cost: 15.00,
        rating: 4, 
        driver_id: new_driver.id,
      )

      @trip3 = Trip.create(
        passenger_id: new_passenger.id,
        date: Date.today,
        cost: 15.00,
        rating: 3, 
        driver_id: new_driver.id,
      )
    end
    describe "average rating" do
      it "calculates average rating for driver with ratings" do
        expect(new_driver.average_rating).must_equal 4.0
      end

      it "returns 'driver has no rating' for driver without ratings" do
        driver_no_trips = Driver.create(name: "It", vin: "123")
        expect(driver_no_trips.average_rating).must_equal "This driver has no ratings"
      end
    end

    describe "total earnings" do
      it "totals earnings for driver" do
        expect(new_driver.total_earnings).must_equal ( @trip1.cost + @trip2.cost + @trip3.cost - ( 3 * 1.65 )) * 0.8 
      end

      it "returns 0 when no earnings" do
        driver_no_trips = Driver.create(name: "It", vin: "123")
        expect(driver_no_trips.total_earnings).must_equal 0
      end
    end
  end
end
