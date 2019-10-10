require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|
      
      # Assert
      expect(passenger).must_respond_to field
    end
  end
  
  describe "relationships" do
    it "can have many trips" do
      skip
      # Arrange
      new_passenger.save
      passenger = Passenger.first
      
      # Assert
      expect(passenger.trips.count).must_be :>, 0
      passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      # expect(new_passenger.errors.messages).must_include :name
      # expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      # expect(new_passenger.errors.messages).must_include :new_passenger
      # expect(new_passenger.errors.messages[:new_passenger]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      @driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      @cost = "545.0"
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
    
    
    describe "request a ride" do
      # Your code here
    end
    
    describe "complete trip" do
      # Your code here
    end
    # You may have additional methods to test here
  end
end
