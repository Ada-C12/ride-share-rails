require "test_helper"
require "pry"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true)
  }
  
  it "can be instantiated" do
    expect(new_driver.valid?).must_equal true
    expect(new_driver).must_be_instance_of Driver
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
      driver = Driver.first
      
      expect(driver.trips.count).must_be :>=, 0
      driver.trips.each do |trip|
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
  
  describe "custom methods" do
    describe "average_rating" do
  
      it "returns a float" do
        new_driver.save
        trip = Trip.create(
          date: "2019-09-02",
          driver_id: new_driver.id,
          passenger_id: 3,
          rating: 5
        )
        binding.pry
        expect(new_driver.average_rating).must_be_kind_of Float
      end
  
      # it "returns a float within range of 1.0 to 5.0" do
      #   average = @driver.average_rating
      #   expect(average).must_be :>=, 1.0
      #   expect(average).must_be :<=, 5.0
      # end
  
      # it "returns zero if no driven trips" do
      #   driver = Driver.new(
      #     name: "Rogers Kool",
      #     vin: "1DZ0"
      #   )
      #   expect(driver.average_rating).must_equal 0
      # end
  
      # it "correctly calculates the average rating" do
      #   trip2 = Trip.new(
      #     date: "2019-09-01",
      #     driver: @driver,
      #     passenger_id: 3,
      #     rating: 1
      #   )
      #   @driver.add_trip(trip2)
  
      #   expect(@driver.average_rating).must_be_close_to (5.0 + 1.0) / 2.0, 0.01
      # end
  
      # it "should return average of trips with in-progress trips" do
      #   trip3 = RideShare::Trip.new(
      #     driver: @driver,
      #     passenger_id: 3,
      #     start_time: Time.new.to_s,
      #     end_time: nil,
      #     rating: nil
      #   )
      #   @driver.add_trip(trip3)
  
      #   expect(@driver.average_rating).must_be_close_to (5.0) / 1.0, 5.0
      # end 
    end
    
    # describe "total earnings" do
      
    # end
    
    # describe "can go online" do
    #   # Your code here
    # end
    
    # describe "can go offline" do
    #   # Your code here
    # end
    
  end
end
