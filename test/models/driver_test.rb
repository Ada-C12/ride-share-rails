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
    
    it "correctly calculates average rating" do
      # Arrange
      new_driver = Driver.create(name: "Kari", vin: "123", active: true)
      new_driver_id = new_driver.id
      new_passenger = Passenger.create(name:"Pass", phone_num: "1234567")
      new_passenger_id = new_passenger.id
      
      new_trip_1 = Trip.create(date: Time.now, cost: 1234, rating: 5, driver_id: new_driver_id, passenger_id: new_passenger_id)
      
      new_trip_2 = Trip.create(date: Time.now, cost: 1234, rating: 1, driver_id: new_driver_id, passenger_id: new_passenger_id)
      
      # Act
      
      # Assert
      expect(new_driver.average_rating).must_equal 3
      expect(new_driver.average_rating).must_be_instance_of Integer
    end
    
  end
  
  describe "total earnings" do
    it "total correctly calculates earnings" do
      # Arrange
      new_driver = Driver.create(name: "Kari", vin: "123", active: true)
      new_driver_id = new_driver.id
      
      new_passenger = Passenger.create(name:"Pass", phone_num: "1234567")
      new_passenger_id = new_passenger.id
      
      new_trip_1 = Trip.create(date: Time.now, cost: 1234, rating: 5, driver_id: new_driver_id, passenger_id: new_passenger_id)
      
      new_trip_2 = Trip.create(date: Time.now, cost: 1234, rating: 1, driver_id: new_driver_id, passenger_id: new_passenger_id)
      
      # Act-Assert
      expect(new_driver.total_earnings).must_equal 17.104
      expect(new_driver.total_earnings).must_be_instance_of Float
    end
  end
  
  
  
end
end
