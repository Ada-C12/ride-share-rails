require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true)
  }
  it "can be instantiated" do
    
    expect(new_driver.valid?).must_equal true
  end
  
  it "will have the required fields" do
    
    new_driver.save
    driver = Driver.first
    [:name, :vin, :active].each do |field|
      
      
      expect(driver).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      
      new_driver.save
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      new_driver.name = nil
      
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a VIN number" do
      
      new_driver.vin = nil
      
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      @passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      @cost = "422.80"
      @trips = Array.new(10) do |n|
        Trip.create(cost: (n+50)*100, driver_id: @driver.id, passenger_id: @passenger.id, rating: (n%5))
      end
    end
    
    #before do to create driver, passengers, trips
    describe "average rating" do
      it "returns an average rating which is a string" do
        
        expect(@driver.average_rating).must_be_instance_of String
        
      end
      
      it "returns an average rating which has 1 digit after the decimal" do
        expect(@driver.average_rating.length).must_equal 3
        expect(@driver.average_rating[1]).must_equal "."
      end
      
      it "returns an accurately valued average rating" do
        test_value = "2.0"
        expect(@driver.average_rating).must_equal test_value
        
      end
      
      it "ignores nil values for ratings in the calculations, will happen with ongoing trips" do
      end
      
      it "returns 0.0 for drivers that have no trips" do
      end
      
    end 
    
    describe "total_earnings" do
      it "returns a string" do
        expect(@driver.total_earnings).must_be_instance_of String
      end
      
      it "can calculate earnings for multiple trips" do
        expect(@driver.total_earnings).must_equal @cost
      end
      
      it "can calculate earnings for no trips" do
        Trip.delete_all
        expect(@driver.total_earnings).must_equal "0.00"
      end
    end
    
    describe "can go online" do
      # Your code here
    end
    
    describe "can go offline" do
      # Your code here
    end
    
    # You may have additional methods to test
  end
end
