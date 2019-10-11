require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  it "can be instantiated" do
    expect(new_passenger.valid?).must_equal true
  end
  
  it "will have the required fields" do
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|
      expect(passenger).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      new_passenger.save
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
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
      new_passenger.name = nil
      expect(new_passenger.valid?).must_equal false
    end
    
    it "must have a phone number" do
      new_passenger.phone_num = nil
      expect(new_passenger.valid?).must_equal false
    end
  end
  
  describe "custom methods" do
    before do
      @passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      @driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      @cost = "545.00"
      @trips = Array.new(10) do |n|
        Trip.create(cost: (n+50)*100, passenger_id: @passenger.id, driver_id: @driver.id)
      end
    end
    
    describe "total_charges" do
      it "returns a string" do
        expect(@passenger.total_charges).must_be_instance_of String
      end
      
      it "returns an accurate value" do
        expect(@passenger.total_charges).must_equal @cost
      end      
    end
  end
end
