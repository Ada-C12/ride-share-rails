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
      new_passenger = Passenger.create(name: "Kari", phone_number: "111-111-1211")
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
  
  # # Tests for methods you create should go here
  describe "custom methods" do
    describe "average rating" do
      it "can calculate an average given multiple ratings" do
        new_driver = Driver.create(name: "Mary", vin: "123", active: true)
        new_passenger = Passenger.create(name: "Berry", phone_number: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 6334)
        
        # Assert
        expect(Driver.driver_avg_rating(new_driver.id)).must_equal 4.5
      end
      
      it "shows nothing (nil) if the driver doesn't have any rating" do
        new_driver = Driver.create(name: "Paul", vin: "123", active: true)
        
        # Assert
        expect(Driver.driver_avg_rating(new_driver.id)).must_equal " "
      end    
    end
    
    describe "total earnings" do
      it "calculates total earnings correctly" do
        
        new_driver = Driver.create(name: "Mary", vin: "123", active: true)
        new_passenger = Passenger.create(name: "Berry", phone_number: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 4, cost: 6334)
        
        # Assert
        expect(Driver.driver_total_earnings(new_driver.id)).must_equal 57.9
      end
      
      it "returns 0 if the driver doesn't have any trips" do
        new_driver = Driver.create(name: "Mary", vin: "123", active: false)
        
        # Assert
        expect(Driver.driver_total_earnings(new_driver.id)).must_equal 0
      end
    end
    
    describe "Online/Offline status" do
    # assuming "go online" means "active: false" aka "available to drive"
      it "can go offline" do
        new_driver = Driver.create(name: "Mary", vin: "123", active: false)
        expect(Driver.find_by(id: new_driver.id).active).must_equal false
      end
      
      it "can go online" do
        new_driver = Driver.create(name: "Mary", vin: "123", active: true)
        expect(Driver.find_by(id: new_driver.id).active).must_equal true
      end
    end

    describe "alphabetic order" do      
      let (:new_driver2) {
      Driver.new(name: "Ana", vin: "123", active: true)
      }
  
      let (:new_driver3) {
        Driver.new(name: "Zima", vin: "123", active: true)
      }
  
      it "sorts the drivers alphabetically" do
        # Arrange
        new_driver.save
        new_driver2.save
        new_driver3.save
  
        # Assert
        expect(Driver.alpha_drivers.first.name).must_equal "Ana"
      end  
    end
  end
end
