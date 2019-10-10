require "test_helper"

describe Trip do
  before do 
    @driver = Driver.create(name: "Jelly Bean", vin: "4839204380")
    @passenger = Passenger.create(name: "Chucky", phone_num: "222-222-2222")
  end

  let (:new_trip) {
    Trip.new(passenger_id: @passenger.id, driver_id: @driver.id, cost: 1000, date: Date.today)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:passenger_id, :driver_id, :cost, :date].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "has Driver and Passenger" do
      new_trip.save
      expect(new_trip.passenger).must_be_instance_of Passenger
      expect(new_trip.driver).must_be_instance_of Driver
    end
  end

  # Tests for methods you create should go here
  # describe "custom methods" do
  #   before do 
  #     @driver_unavailable = Driver.create(name: "XX", vin: "4839204380", available: false)
  #     @driver_available = Driver.create(name: "JJ", vin: "4839204380", available: true)
      
  #     @passenger = Passenger.create(name: "Chucky", phone_num: "222-222-2222")
  #   end

  #   it "create trip method finds first available driver" do
  #     Trip.create_new_trip(@passenger.id)

  #     expect(@driver_available.available).must_equal false
  #   end

  # end
end
