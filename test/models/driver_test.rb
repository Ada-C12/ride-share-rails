require "test_helper"



describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", status: "available")
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :status].each do |field|

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
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank", "is invalid"]
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
  let (:new_driver) { Driver.create(name: "Kari", vin: "123")}
  describe "custom methods" do


    it "averages the ratings amongst completed trips" do
      passenger = Passenger.create(name: "Jessica", phone_num: 334-876-2345)

      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Feb 25, 2019"), rating: 3, cost: 2344)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Jan 23, 2000"), rating: 3, cost: 2344)
      trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Dec 12, 2014"), rating: 3, cost: 2344)

      expect(new_driver.avg_rating).must_equal 3

    end 

    it "total earnings" do
      passenger = Passenger.create(name: "Jessica", phone_num: 334-876-2345)

      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Feb 25, 2019"), rating: 3, cost: 5)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Jan 23, 2000"), rating: 3, cost: 5)
      trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Dec 12, 2014"), rating: 3, cost: 5)

      expect(new_driver.total_earnings).must_equal 8.04
    end

    it "can go online" do
      expect(new_driver.status).must_equal "available" 

    
    end

    it "can go offline" do
  
      passenger = Passenger.create(name: "Jessica", phone_num: 334-876-2345)
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: passenger.id, date: Date.parse("Feb 25, 2019"), rating: nil, cost: 2344)
      
      expect(new_driver.reload.status).must_equal "unavailable"
    end

    # You may have additional methods to test
  end
end
