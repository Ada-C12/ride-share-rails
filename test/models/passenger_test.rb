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
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end
    
    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # describe "request a ride" do
    #   # Your code here
    # end
    
    # describe "complete trip" do
    #   # Your code here
    # end
    # # You may have additional methods to test here
    # describe "alpha passenger" do 
    #   #how do we test alpha passenger
    # end 
    
    describe "total_spent" do
      it "can calculate total spent on trips for a passenger" do
        @driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
        
        @passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
        
        Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 3, date: Date.today, cost: 250)
        Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 4, date: Date.today, cost: 350)
        Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, rating: 5, date: Date.today, cost: 200.25)
        
        expect(@passenger.total_spent).must_equal "800.25"
      end
    end
  end
end
