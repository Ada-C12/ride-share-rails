require "test_helper"

describe Trip do
  # let (:new_trip) {
  #   Trip.new(date: Time.now, cost: 2150, rating:5, driver_id: , passenger_id: )
  # }
  it "can be instantiated" do
    # Assert
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_trip.save
    trip = Trip.first
    [:date, :cost, :rating].each do |field|
      #Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to driver" do
      new_trip.save
      trip = Trip.first

      # Assert
      expect(trip.driver.count).must_be 1
      expect(trip.driver).must_be_instance_of Driver
    end
  end

  describe "validations" do
    it "must have a date" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :cost
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a passenger" do
      # Arrange
      new_trip.passenger = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :passenger_id
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a driver" do
      # Arrange
      new_trip.driver = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :driver_id
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
