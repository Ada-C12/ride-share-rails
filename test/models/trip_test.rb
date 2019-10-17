require "test_helper"

describe Trip do
  
  before do
    @driver = Driver.create name: "Meatball Jones", vin: "1234", active: false, car_make: "Honda", car_model: "Accord"
    @passenger = Passenger.create name: "Squidward Squid", phone_number: "123-456-7890"
  end
  
  let (:new_trip) {
    Trip.new(
      date: Date.new(2019,10,8),
      passenger_id: Passenger.first.id,
      driver_id: Driver.first.id,
      cost: "23.10"
    )
  }
  
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    new_trip.save
    saved_trip = Trip.first
    
    [:date, :passenger_id, :driver_id, :cost].each do |field|
      expect(saved_trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    before do
      new_trip.save
      @saved_trip = Trip.first
    end
    
    it "has a passenger" do
      expect(@saved_trip.passenger).must_be_instance_of Passenger
    end
    
    it "has a driver" do
      expect(@saved_trip.driver).must_be_instance_of Driver
    end
  end
  
  describe "validations" do
    # Jared made a Project Notification post about how we don't need to test validations.
  end
  
  describe "custom methods" do
    # No custom methods made for Trip class
  end
end
