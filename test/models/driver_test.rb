require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  it "can be instantiated" do
    new_driver = Driver.new(name: "Kari", vin: "xxxxxxxxxxxxxxxxx", available: true)  
    expect(new_driver.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|
      
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
      expect(new_driver.errors.messages[:name]).must_equal ["Field cannot be empty!"]
    end
    
    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil
      
      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["Field cannot be empty!", "Please enter the correct number of characters!"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      it "can calculate average rating for a driver" do
        test_driver = Driver.create(name: "driver test", vin: "xxxxxxxxxxxxxxxxx", available: true)
        trip_1 = Trip.create(passenger_id: 1, driver_id: test_driver.id, date: 10/10/10, rating: 5, cost: 0.00)
        trip_2 = Trip.create(passenger_id: 2, driver_id: test_driver.id, date: 10/12/10, rating: 4, cost: 0.00)
        trip_3 = Trip.create(passenger_id: 3, driver_id: test_driver.id, date: 10/13/10, rating: 3, cost: 0.00)
        
        rating = test_driver.average_rating
        
        expect(rating).must_equal 4
      end
      
      
    end
    
    describe "total earned" do
      it "can caluclate the total earnings for a driver" do
        test_driver = Driver.create(name: "driver test", vin: "xxxxxxxxxxxxxxxxx", available: true)
        trip_1 = Trip.create(passenger_id: 1, driver_id: test_driver.id, date: 10/10/10, rating: 5, cost: 5.00)
        trip_2 = Trip.create(passenger_id: 2, driver_id: test_driver.id, date: 10/12/10, rating: 0, cost: 5.00)
        
        
        earnings = test_driver.total_earned
        
        expect(earnings).must_equal 10.00
      end
      # Your code here
    end
    
    describe "assign driver" do
      it "can assign an available driver to a new trip" do
        test_driver = Driver.create(name: "driver test", vin: "xxxxxxxxxxxxxxxxx", available: true)
        
        expect {
          post drivers_path, params: driver_hash
        }.must_change "Driver.count", 1
        
        trip_1 = Trip.create(passenger_id: 1, driver_id: test_driver.id, date: nil, rating: 5, cost: 0.00)
        
        expect {
          post trips_path, params: trip_hash
        }.must_change "Trip.count", 1
        
        expect(trip_1.driver_id).must_equal test_driver.id
        
        
      end
      
      
    end
    
  end
end
