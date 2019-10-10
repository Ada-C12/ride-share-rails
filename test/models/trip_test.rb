require "test_helper"

describe Trip do
  let (:new_driver) { Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) }
  let (:new_passenger) { Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") }
  let (:new_trip) {Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: "2016-04-05", rating: 3, cost: 1250 ) }
  
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_trip.save
    
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      
      # Assert
      expect(trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "has a driver object" do
      # Arrange
      new_trip.save
      trip = Trip.first
      
      # Assert
      expect(trip.driver).must_be_instance_of Driver
    end
    
    it "has a passenger object" do
      # Arrange
      new_trip.save
      trip = Trip.first
      
      # Assert
      expect(trip.passenger).must_be_instance_of Passenger
    end
  end
  
  describe "validations" do
    it "must have a driver_id" do
      # Arrange
      bad_trip = Trip.create(driver_id: nil, passenger_id: new_passenger.id, date: "2016-04-05", rating: 3, cost: 1250 )
      
      # Assert
      expect(bad_trip.valid?).must_equal false
      expect(bad_trip.errors.messages).must_include :driver_id
      expect(bad_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end
    
    it "must have a passenger_id" do
      # Arrange
      bad_driver = Trip.create(driver_id: new_driver.id, passenger_id: nil, date: "2016-04-05", rating: 3, cost: 1250 )
      
      # Assert
      expect(bad_driver.valid?).must_equal false
      expect(bad_driver.errors.messages).must_include :passenger_id
      expect(bad_driver.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end
    
    it "must have a date" do
      # Arrange
      bad_driver = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: nil, rating: 3, cost: 1250 )
      
      # Assert
      expect(bad_driver.valid?).must_equal false
      expect(bad_driver.errors.messages).must_include :date
      expect(bad_driver.errors.messages[:date]).must_equal ["can't be blank"]
    end
    
    it "must have a cost" do
      # Arrange
      bad_driver = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: "2016-04-05", rating: 3, cost: nil )
      
      # Assert
      expect(bad_driver.valid?).must_equal false
      expect(bad_driver.errors.messages).must_include :cost
      expect(bad_driver.errors.messages[:cost]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
