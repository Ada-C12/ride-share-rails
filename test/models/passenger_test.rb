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

      driver = Driver.create(
        name: "Sarah",
        vin: "848485859",
        car_make: "Ford",
        car_model: "Escape",
        active: true
      )
  
      trip_1 = Trip.create(
        date: "10-09-2019",
        rating: 3,
        cost: 2040,
        passenger_id: passenger.id,
        driver_id: driver.id
      )

      trip_2 = Trip.create(
        date: "10-19-2019",
        rating: 4,
        cost: 1140,
        passenger_id: passenger.id,
        driver_id: driver.id
      )

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
    describe "request a ride" do
      # Your code here
    end

    describe "complete trip" do
      # Your code here
    end

    describe "total expense" do
      before do
        new_passenger.save
        @passenger = Passenger.first
  
        driver = Driver.create(
          name: "Sarah",
          vin: "848485859",
          car_make: "Ford",
          car_model: "Escape",
          active: true
        )
    
        trip_1 = Trip.create(
          date: "10-09-2019",
          rating: 3,
          cost: 2040,
          passenger_id: @passenger.id,
          driver_id: driver.id
        )
  
        trip_2 = Trip.create(
          date: "10-19-2019",
          rating: 4,
          cost: 1140,
          passenger_id: @passenger.id,
          driver_id: driver.id
        )
      end

      it "can calculate the correct amount of total expense for a passenger" do
        total_expense = @passenger.trips.map{|trip| trip.cost }.sum
        expect(@passenger.total_expense).must_equal total_expense
      end
    end
    # You may have additional methods to test here
  end
end
