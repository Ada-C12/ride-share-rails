require "test_helper"

describe Trip do
  before do
    @driver = Driver.create(name: "Kari", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
    @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
    @new_trip = Trip.create(date: DateTime.now, rating: 2, cost: 1000, driver_id: @driver.id, passenger_id: @passenger.id)
  end
  
  it "can be instantiated" do
    expect(@new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    trip = Trip.first
    [:date, :rating, :cost, :driver_id, :passenger_id].each do |field|
      expect(trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have a single passenger and driver" do
      trip = Trip.first
      
      expect(trip.driver).must_be_instance_of Driver
      expect(trip.passenger).must_be_instance_of Passenger
    end
  end
  
  describe "validations" do
    it "must have a date" do
      @new_trip.date = nil
      
      expect(@new_trip.valid?).must_equal false
      expect(@new_trip.errors.messages).must_include :date
      expect(@new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end
    
    it "must have a cost" do
      @new_trip.cost = nil
      
      expect(@new_trip.valid?).must_equal false
      expect(@new_trip.errors.messages).must_include :cost
      expect(@new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end
    
    it "must have a driver_id" do
      @new_trip.driver_id = nil
      
      expect(@new_trip.valid?).must_equal false
      expect(@new_trip.errors.messages).must_include :driver_id
      expect(@new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end
    
    it "must have a passenger_id" do
      @new_trip.passenger_id = nil
      
      expect(@new_trip.valid?).must_equal false
      expect(@new_trip.errors.messages).must_include :passenger_id
      expect(@new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end
  end
  
end
