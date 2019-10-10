require "test_helper"
require "pry"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: false)
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
  
      it "returns a float and within range 1.0-5.0" do
        new_driver.save
        passenger = Passenger.create(name:"Coolio Foolio", phone_num: "206-800-5000")

        Trip.create(
          date: "2019-09-01",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 5,
          cost: 1
        )

        expect(new_driver.average_rating).must_be_kind_of Float
        expect(new_driver.average_rating).must_be :>=, 1.0
        expect(new_driver.average_rating).must_be :<=, 5.0
      end
  
      it "returns zero if no driven trips" do
        driver = Driver.new(
          name: "Rogers Kool",
          vin: "1DZ0"
        )
        driver.save
        expect(driver.average_rating).must_equal 0
      end
  
      it "correctly calculates the average rating" do
        new_driver.save
        passenger = Passenger.create(name:"Coolio Foolio", phone_num: "206-800-5000")

        Trip.create(
          date: "2019-09-01",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 5,
          cost: 1
        )

        Trip.create(
          date: "2019-09-02",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 3,
          cost: 1
        )
  
        expect(new_driver.average_rating).must_be_close_to (5.0 + 3.0) / 2.0, 0.01
      end
    end
    
    describe "total earnings" do
      it "returns total revenue of driver" do 
        new_driver.save
        passenger = Passenger.create(name:"Coolio Foolio", phone_num: "206-800-5000")

        Trip.create(
          date: "2019-09-01",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 5,
          cost: 3
        )

        Trip.create(
          date: "2019-09-02",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 3,
          cost: 5
        )

        expect(new_driver.earnings).must_equal 4.00
      end 

      it "should return average of trips with in-progress trips" do
        Trip.new(
          id: 8,
          driver: new_driver.id,
          passenger_id: passenger.id,
          rating: nil,
          cost: 3
        )

        expect(new_driver.total_revenue).must_equal 9.36
      end 
    end 
  end
end
