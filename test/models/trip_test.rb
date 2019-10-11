require "test_helper"

describe Trip do
  driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
  new_trip = Trip.create(driver_id: driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234)
  
  it "can be instantiated" do
    # Assert
    expect(new_trip.valid?).must_equal true
  end
  
  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    [:driver, :passenger_id, :date, :rating, :cost].each do |field|
      
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
