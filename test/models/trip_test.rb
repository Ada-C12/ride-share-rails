require "test_helper"

describe Trip do
  let (:new_driver) { Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) }
  let (:new_passenger) { Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") }
  let (:new_trip) {Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: "2016-04-05", rating: 3, cost: 1250 ) }
  
  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_trip.save
    
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      
      # Assert
      expect(trip).must_respond_to field
    end
  end
  
  describe "relationships" do
    # Your tests go here
  end
  
  describe "validations" do
    # Your tests go here
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
