require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  
  it "can be instantiated" do
    expect(new_driver.valid?).must_equal true
  end
  
  it "will have the required fields" do
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|
      
      expect(driver).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      new_driver.save
      
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      expect(new_driver.trips.count).must_equal 2
      new_driver.trips.each do |trip|
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
  
  describe "average rating" do
    it "must return the average rating for a driver" do 
      new_driver.save
      
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      expect(new_driver.avg_rating).must_equal 4
    end
  end 
  
  describe "total earnings" do  
    it "must return the total cost of the driver's trips" do 
      new_driver.save
      
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211") 
      trip = Trip.new(driver_id: new_driver.id, passenger_id: new_passenger.id, rating: 4, cost: 2205, date: Date.today) 
      trip.save
      
      expect(new_driver.total_earnings).must_equal(((2205 - 165) * 0.80)/100)
    end
  end
end
