require "test_helper"

describe Driver do
  let (:unavailable_driver) { Driver.new(name: "Ben", vin: "456", available: false, car_make: "Honda", car_model: "Fit") }
  let (:new_driver) { Driver.new(name: "Kari", vin: "123", available: true, car_make: "Cherry", car_model: "DR5") }
  let (:new_passenger) { Passenger.create(name: "Kari", phone_num: "111-111-1211") }
  
  describe "initialize" do
    it "can be instantiated" do
      # Assert
      expect(new_driver.valid?).must_equal true
    end
    
    it "will have the required fields" do
      # Arrange
      new_driver.save
      driver = Driver.first
      [:name, :vin, :available, :car_make, :car_model].each do |field|
        
        # Assert
        expect(driver).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      new_passenger.save
      
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      # Assert
      expect(new_driver.trips.count).must_equal 2
      
      new_driver.trips.each do |trip|
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
  
  describe "get available driver" do
    it "gets an available driver" do
      unavailable_driver.save
      new_driver.save 
      
      first_driver = Driver.get_available_driver
      
      expect(first_driver).must_be_instance_of Driver
      expect(first_driver.available).must_equal true
    end
    
    it "returns nil if no drivers are available" do
      unavailable_driver.save
      
      first_driver = Driver.get_available_driver
      
      assert_nil(first_driver)
    end
  end
  
  describe "average rating" do
    it "calculates the correct average rating for multiple trips" do
      new_driver.save
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 2, cost: 100)
      
      expect(new_driver.average_rating).must_equal 3.33
    end
    
    it "returns the same rating if there is only one trip" do
      new_driver.save
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      
      expect(new_driver.average_rating).must_equal 5
    end
  end
  
  describe "total earnings" do
    it "calculates the correct earnings for multiple trips" do
      new_driver.save
      
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      trip_3 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 100)
      
      expect(new_driver.total_earnings).must_equal 57.90
    end
    
    it "returns the correct price if there is only one trip" do
      new_driver.save
      
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      
      expect(new_driver.total_earnings).must_equal 8.55
    end
  end
  
  describe "toggle availability" do
    it "can turn a driver from available to unavailable" do
      new_driver.save
      
      new_driver.toggle_available
      
      updated_driver = Driver.find_by(id: new_driver.id)
      
      expect(updated_driver.available).must_equal false
    end
    
    it "can turn a driver from unavailable to available" do
      unavailable_driver.save
      
      unavailable_driver.toggle_available
      
      updated_driver = Driver.find_by(id: unavailable_driver.id)
      
      expect(updated_driver.available).must_equal true
    end
  end
end
