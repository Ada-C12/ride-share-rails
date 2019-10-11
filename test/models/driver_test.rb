  require "test_helper"
  require "date"
  
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
        
        new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
        ​
        # Assert
        expect(new_passenger.trips.count).must_equal 2
        new_passenger.trips.each do |trip|
          expect(trip).must_be_instance_of Trip
        end
      end
      
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
      # Your code here
    end
    
    describe "total earnings" do
      before do
        @new_driver = Driver.create(name: "Robert", vin: "r45g6")   
        @new_passenger = Passenger.create(name: "Robert", phone_num: "r45g6")   
        @trip = Trip.new(driver_id: @new_driver.id, passenger_id: @new_passenger.id, rating: 4, cost: 905, date: Date.new(2001,2,3)) 
        @trip.save
      end
      
      it "must return the total cost of the driver's trips" do 
        # Arrange
        # new_driver.save
        # driver_id = new_driver.id
        expect(@new_driver.total_earnings).must_equal((905 - 1.65) * 0.80)
      end
    end
    
    #   describe "can go online" do
    #     # Your code here
    #   end
    
    #   describe "can go offline" do
    #     # Your code here
    #   end
    
    #   # You may have additional methods to test
  end
end
