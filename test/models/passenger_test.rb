require "test_helper"

describe Passenger do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }

  it "can be instantiated" do
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
      new_driver = Driver.create(name: "Kari", vin: "123")

      @trip1 = Trip.create(
        passenger_id: passenger.id,
        date: Date.today,
        cost: 1000,
        rating: 5,
        driver_id: new_driver.id,
      )

      @trip2 = Trip.create(
        passenger_id: passenger.id,
        date: Date.today,
        cost: 1500,
        rating: 4, 
        driver_id: new_driver.id,
      )

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
    describe "total charged method" do
      before do 
        new_passenger.save
        new_driver = Driver.create(name: "Kari", vin: "123")
        @trip1 = Trip.create(
          passenger_id: new_passenger.id,
          date: Date.today,
          cost: 1000,
          rating: 5,
          driver_id: new_driver.id,
        )
  
        @trip2 = Trip.create(
          passenger_id: new_passenger.id,
          date: Date.today,
          cost: 1500,
          rating: 4, 
          driver_id: new_driver.id,
        )
      end

      it "calculates total charged in trips for passenger" do
        expect(new_passenger.total_charged).must_equal @trip1.cost + @trip2.cost
      end

      it "returns 0 if no trips for passenger" do
        passenger_no_trips = Passenger.create(name: "Ghost Passenger", phone_num: "111-111-1211")

        expect(passenger_no_trips.total_charged).must_equal 0
      end
    end
  end
end
