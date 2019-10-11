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
    it "can calculate the average rating for a driver" do
      @driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      
      @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 250)
      
      expect(@driver.avg_rating).must_equal 4.00
    end
  end
  
  describe "total earnings" do
    it "can calculate total earnings for a driver" do
      @driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      
      @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 300)
      Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 200.25)
      
      expect(@driver.total_earnings).must_equal 750.25
    end
  end
  
  describe "can go online" do
    it "can turn active status from true to false" do
      # Your code here
      @driver = Driver.create(name: "Kari", vin: "123", active: true,
      car_make: "Cherry", car_model: "DR5")
      
      @driver.toggle_status
      
      expect(@driver.active).must_equal false
    end
  end
  
  describe "can go offline" do
    it "can turn active status from false to true" do
      # Your code here
      @driver = Driver.create(name: "Kari", vin: "123", active: false,
      car_make: "Cherry", car_model: "DR5")
      
      @driver.toggle_status
      
      expect(@driver.active).must_equal true
    end
  end
  
  # You may have additional methods to test
end
end
