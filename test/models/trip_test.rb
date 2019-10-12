require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
    @driver = Driver.create(name: "Kari", vin: "123", active: true,
    car_make: "Cherry", car_model: "DR5")
    @trip = Trip.create(passenger_id: @passenger.id, driver_id: @driver.id)
  end
  
  it "can be instantiated" do
    expect(@trip).must_be_instance_of Trip
  end
  
  it "will have the required fields" do
    [:passenger_id, :driver_id, :date, :rating, :cost].each do |field|
      expect(@trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have only one driver" do
      trip = Trip.first
      expect(@trip.driver).must_be_instance_of Driver
    end
  end
  
  describe "validations" do
    it "must have a passenger id" do
      pass_id = @passenger.id
      trip_1 = Trip.create(passenger_id: @passenger.id)
      expect(trip_1.passenger_id).must_equal pass_id
      expect(trip_1.passenger).must_be_instance_of Passenger
    end
    it "must have a driver id" do
      driv_id = @driver.id
      trip_1 = Trip.create(passenger_id: @passenger.id, driver_id: @driver.id)
      expect(trip_1.driver_id).must_equal driv_id
      expect(trip_1.driver).must_be_instance_of Driver
    end
  end
  
  describe "custom methods" do
    it "will order trips chronologically" do
      trip_1 = Trip.create(passenger_id: @passenger.id, driver_id: @driver.id, date: "2017-5-3")
      trip_2 = Trip.create(passenger_id: @passenger.id, driver_id: @driver.id)
      expect(@passenger.trips.chrono_trips.first).must_equal trip_1
      
    end
  end
end
