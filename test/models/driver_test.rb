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
      # driver = Driver.create(name: "Kari", vin: "123", active: false)
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
          cost: 10
        )

        Trip.create(
          date: "2019-09-02",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 3,
          cost: 12
        )
  
        expect(new_driver.average_rating).must_be_close_to (5.0 + 3.0) / 2.0, 0.01
      end
    end
    
    describe "net_earning" do
      it "returns cost for one trip" do 
        new_driver.save
        passenger = Passenger.create(name:"Coolio Foolio", phone_num: "206-800-5000")

        Trip.create(
          date: "2019-09-01",
          driver_id: new_driver.id,
          passenger_id: passenger.id,
          rating: 5,
          cost: 1000
        )
        
        trip_cost = Trip.find_by(driver_id: new_driver.id).cost

        expect(new_driver.net_earning(trip_cost)).must_equal 668
      end 
    end 
  end
end
