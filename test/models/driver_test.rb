require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
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
    describe "average rating and total earnings" do
      before do
        @driver = Driver.create name: "Meatball Jones", vin: "1234", active: false, car_make: "Honda", car_model: "Accord"
        @passenger = Passenger.create name: "Squidward Squid", phone_number: "123-456-7890"
        
        @trip1 = Trip.create date: Date.new(2019,10,8), passenger_id: Passenger.first.id, driver_id: @driver.id, cost: "2310", rating: "5"
        @trip2 = Trip.create date: Date.new(2019,10,9), passenger_id: Passenger.first.id, driver_id: @driver.id, cost: "10", rating: "3"
        @trip3 = Trip.create date: Date.new(2019,10,10), passenger_id: Passenger.first.id, driver_id: @driver.id, cost: "31", rating: "1"
      end
      it "must calculate the correct average rating" do
        expect(@driver.avg_rating).must_equal 3
      end
      it "must calculate the correct total earnings" do
        expect(@driver.total_earnings).must_equal 1879.48
      end
    end
    
    describe "active_toggle" do
      it "can go online" do
        inactive_driver = Driver.create(name: "Available Driver", vin: "1234", active: false, car_make: "Toyota", car_model: "Prius")
        before_status = inactive_driver.active
        
        expect(before_status).must_equal false
        
        inactive_driver.active_toggle
        after_status = inactive_driver.active
        
        expect(after_status).must_equal true
      end
      
      it "can go offline" do
        active_driver = Driver.create(name: "Active Driver", vin: "1234", active: true, car_make: "Toyota", car_model: "Prius")
        before_status = active_driver.active
        
        expect(before_status).must_equal true
        
        active_driver.active_toggle
        after_status = active_driver.active
        
        expect(after_status).must_equal false
      end
    end
    
    describe "self.find_available" do
      it "will only return an available (inactive) driver" do
        active_driver = Driver.create(name: "Active Driver", vin: "1234", active: true, car_make: "Toyota", car_model: "Prius")
        inactive_driver = Driver.create(name: "Available Driver", vin: "1234", active: false, car_make: "Toyota", car_model: "Prius")
        
        expect(Driver.count).must_equal 2
        
        found_driver = Driver.find_available
        
        expect(found_driver).wont_be_nil
        expect(found_driver.id).must_equal inactive_driver.id
        
        found_driver.active_toggle
        
        second_found_driver = Driver.find_available
        expect(second_found_driver).must_be_nil
      end
    end
  end
end

