require "test_helper"

describe Trip do
  driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
  new_trip = Trip.create(driver_id: driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234)
  
  it "can be instantiated" do
    # Assert
    expect(new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    [:driver, :passenger_id, :date, :rating, :cost].each do |field|
      
      # Assert
      expect(trip).must_respond_to field
    end
  end
  
  
  describe "relationships" do
    it "has one passenger" do
      # Arrange
      passenger = Passenger.first
      driver = Driver.create(name: "Joe Driver", vin: "1234567890")
      trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      # Assert
      expect(trip.passenger).must_be_instance_of Passenger
    end
    
    it "has one driver" do
      # Arrange
      passenger = Passenger.first
      driver = Driver.create(name: "Joe Driver", vin: "1234567890")
      trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      # Assert
      expect(trip.driver).must_be_instance_of Driver
    end
  end
  
  describe "validations" do
    it "must have a date" do
      # Arrange
      passenger = Passenger.first
      driver = Driver.first
      validate_trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      validate_trip.date = nil
      
      # Assert
      expect(validate_trip.valid?).must_equal false
      expect(validate_trip.errors.messages).must_include :date
      expect(validate_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end
    
    it "must have a passenger" do
      # Arrange
      passenger = Passenger.first
      driver = Driver.first
      validate_trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      validate_trip.passenger = nil
      
      # Assert
      expect(validate_trip.valid?).must_equal false
      expect(validate_trip.errors.messages).must_include :passenger
      expect(validate_trip.errors.messages[:passenger]).must_equal ["must exist", "can't be blank"]
    end
    
    it "must have a driver" do
      # Arrange
      passenger = Passenger.first
      driver = Driver.first
      validate_trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      validate_trip.driver = nil
      
      # Assert
      expect(validate_trip.valid?).must_equal false
      expect(validate_trip.errors.messages).must_include :driver
      expect(validate_trip.errors.messages[:driver]).must_equal ["must exist", "can't be blank"]
    end
  end
  
  # # Tests for methods you create should go here
  describe "custom methods" do
    it "sorts dates correctly" do
      
      trips = Trip.all_in_alpha_order
      expect(trips.first.date <= trips.last.date).must_equal true
      
    end
    
    it "coverts pennies to dollars correctly" do
      passenger = Passenger.first
      driver = Driver.first
      converted_trip = Trip.create( passenger_id: passenger.id, driver_id: driver.id, rating: 5, cost: 2222, date: Date.today)
      
      expect(converted_trip.convert_to_dollars(converted_trip.cost)).must_be_close_to 22.22, 0.01
      
    end
  end
end
