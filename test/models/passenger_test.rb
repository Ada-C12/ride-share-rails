require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "New Passenger", phone_num: "999-999-9999")
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

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "total_money_spent" do
      # Your code here
    end
  end
end
