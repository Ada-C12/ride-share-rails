require "test_helper"

describe Passenger do
  let (:passenger_test) {
    Passenger.new(name: "New Passenger", phone_num: "999-999-9999")
  }
  it "can be instantiated" do
    # Assert
    expect(passenger_test.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    passenger_test.save
    passenger = Passenger.first
    [:name, :phone_num].each do |field|

    # Assert
      expect(passenger).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      passenger_test.save
      passenger = Passenger.first

      # Assert
      expect(passenger.trips.count).must_be :>, 0
      passenger.trips.each do |trip|
        expect(trips).must_be_instance_of Trip
      end
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "total_money_spent" do
      # Your code here
    end
    # You may have additional methods to test here
  end
end
