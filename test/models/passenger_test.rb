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

    describe "find_passenger_trips" do
      it "returns all the trips from a specific passenger" do
        
      end
    end
    
    describe "amount_charged" do
      it "returns the total amount charged to a passenger" do
        # @passenger.add_trip(RideShare::Trip.new(
        #   id: 8,
        #   driver: @driver,
        #   passenger_id: 6,
        #   start_time: "2016-08-08",
        #   end_time: "2016-08-09",
        #   rating: 5,
        #   cost: 12,
        # ))
  
        # @dpassenger.add_trip(RideShare::Trip.new(
        #   id: 5,
        #   driver: @driver,
        #   passenger_id: 3,
        #   start_time: "2016-08-08",
        #   end_time: "2016-08-09",
        #   rating: 5,
        #   cost: 25,
        # ))
        # expect(@driver.total_revenue).must_equal 28.28
      end
    
    end
  end
end