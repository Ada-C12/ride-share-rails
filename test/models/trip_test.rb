require "test_helper"

describe Trip do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true)
  }
  

  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  

  let (:new_trip) {
    Trip.new(
      date: Date.today,
      cost: 10, 
      passenger_id: new_passenger.id,
      driver_id: new_driver.id
    )
  }

  it "can be instantiated" do
    #Arrange
    new_driver.save
    new_passenger.save
    # Assert
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    new_passenger.save
    new_trip.save
    trip = Trip.first
    [:date, :passenger_id, :driver_id, :cost, :rating].each do |field|

      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have one passenger" do
      # Arrange
      new_driver.save
      new_passenger.save
      new_trip.save
      trip = Trip.first

      # Assert
      expect(trip.passenger).must_be_instance_of Passenger
    end

    it "can have one driver" do
      # Arrange
      new_driver.save
      new_passenger.save
      new_trip.save
      trip = Trip.first

      # Assert
      expect(trip.driver).must_be_instance_of Driver
    end
  end

  describe "validations" do
    # Your tests go here
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end