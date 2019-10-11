require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
    @driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
  end
  
  it "can be instantiated" do
    test_trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id)
    expect(test_trip).must_be_instance_of Trip
  end
  
  it "will have the required fields" do
    test_trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id)
    
    [:id, :driver_id, :passenger_id, :date, :cost, :rating].each do |field|
      expect(test_trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    # Relationships are tested through driver and passenger model tests. 
  end
  
  describe "validations" do
    # Your tests go here
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
