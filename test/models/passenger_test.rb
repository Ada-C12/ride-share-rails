require "test_helper"

describe Passenger do
  let (:new_passenger) { Passenger.new(name: "Kari", phone_num: "111-111-1211") }
  let (:new_driver) { Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) }
  let (:new_trip) { Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: "2016-04-05", rating: 3, cost: 1250 ) }
  let (:second_trip) { Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: "2016-04-10", rating: 5, cost: 500 ) }
  
  it "can be instantiated" do
    # Arrange
    new_passenger.save
    
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
      
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      # Assert
      expect(new_passenger.trips.count).must_equal 2
      new_passenger.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end
  
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil
      new_passenger.save
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["Name can't be blank"]
    end
    
    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil
      new_passenger.save
      
      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["Phone number can't be blank"]
    end
  end
  
  describe "custom methods" do    
    describe "total money spent" do
      it "returns 0 if there are no trips" do
        new_passenger.save
        
        expect(new_passenger.total_money_spent).must_equal 0
      end
      
      it "returns the correct float if there is one trip" do
        new_passenger.save
        new_trip.save
        
        expect(new_passenger.total_money_spent).must_equal 12.50
      end
      
      it "returns the correct float if there are mutliple trips" do
        new_passenger.save
        new_trip.save
        second_trip.save
        
        expect(new_passenger.total_money_spent).must_equal 17.50
      end
    end
  end
end
