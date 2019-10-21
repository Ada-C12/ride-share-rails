require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_number: "111-111-1211")
  }
  it "can be instantiated" do
    # Assert
    expect(new_passenger.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_passenger.save
    passenger = Passenger.first
    [:name, :phone_number].each do |field|

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

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a phone number" do
      # Arrange
      new_passenger.phone_number = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_number
      expect(new_passenger.errors.messages[:phone_number]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    #Removed as we didn't create a method in the passenger model for this action.
    # describe "request a ride" do
    # end

    #Removed as we don't have complete trip functionality.
    # describe "complete trip" do
    # end

    let (:new_passenger2) {
    Passenger.new(name: "Ana", phone_number: "111-111-1211")
    }

    let (:new_passenger3) {
    Passenger.new(name: "Zeneca", phone_number: "111-111-1211")
    }

    it "sorts the passengers alphabetically" do
      # Arrange
      new_passenger.save
      new_passenger2.save
      new_passenger3.save

      # Assert
      expect(Passenger.alpha_passengers.first.name).must_equal "Ana"
    end

  end
end
