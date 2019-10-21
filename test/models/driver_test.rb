require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123")
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin].each do |field|
      
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
      let (:new_driver) {
        Driver.new(name: "Kari", vin: "123")
      }
      # Your code here
      it "calculates the average rating of a driver" do
        passenger = Passenger.new(name: "Friendly Passenger", phone_num: "206-867-5309")
        passenger.save
        trip = Trip.create( passenger: Passenger.first, driver: new_driver, rating: 5, cost: 2222, date: Date.today)
        
        expect(new_driver.avg_rating).must_equal 5
      end
      
      it "returns a message if the driver has 0 ratings" do
        expect(new_driver.avg_rating).must_equal "Not rated"
      end
      
      it "returns 0 if the driver has an average rating of 0" do
        passenger = Passenger.new(name: "Friendly Passenger", phone_num: "206-867-5309")
        passenger.save
        trip = Trip.create( passenger: Passenger.first, driver: new_driver, rating: 0, cost: 2222, date: Date.today)
        
        expect(new_driver.avg_rating).must_equal 0
      end
    end
    
    describe "total earnings" do
      let (:new_driver) {
        Driver.new(name: "Kari", vin: "123")
      }
      
      it "calculates the total earnings of a driver" do
        passenger = Passenger.new(name: "Friendly Passenger", phone_num: "206-867-5309")
        passenger.save
        trip1 = Trip.create( passenger: Passenger.first, driver: new_driver, rating: 4, cost: 2222, date: Date.today)
        trip2 = Trip.create( passenger: Passenger.first, driver: new_driver, rating: 4, cost: 2222, date: Date.today)
        
        expect(new_driver.earnings).must_be_close_to 32.91, 0.02
      end
      
      it "returns a message if the driver has 0 trips" do
        expect(new_driver.earnings).must_equal "No earnings"
      end
      
    end
    
    describe "can go online" do
      it "sets a new driver to inactive" do
        driver = Driver.create(name: "Rideshare Driver", vin: "5678")
        
        expect(driver.active).must_equal false
      end
    end
    
    describe "can go offline" do
      it "sets a driver to active" do
        driver = Driver.create(name: "Kari", vin: "123")
        driver.active = true
        expect(driver.active).must_equal true
        # Although this test template is in the Model, we added our method in the Controller.
        # Please refer to controllers/drivers_controller_test.rb:193
      end
    end
    
    # You may have additional methods to test
  end
end
