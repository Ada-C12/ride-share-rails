require "test_helper"

describe Trip do
  before do
    @passenger = Passenger.create(
      name: "Alexa",
      phone_num: "865309"
    )

    @driver = Driver.create(
      name: "Sarah",
      vin: "848485859",
      car_make: "Ford",
      car_model: "Escape",
      active: true
    )

    @trip = Trip.new(
      date: "08-09-2019",
      rating: 4,
      cost: 740,
      passenger_id: @passenger.id,
      driver_id: @driver.id
    )
  end

  it "can be instantiated" do
    expect(@trip.valid?).must_equal true
  end

  it "will have the required fields" do
    Trip.destroy_all
    @trip.save
    trip = Trip.first
    [:date, :rating, :cost, :passenger_id, :driver_id].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have one driver and one passenger" do
      @trip.save
      trip = Trip.first

      expect(trip.driver).must_be_instance_of Driver
      expect(trip.passenger).must_be_instance_of Passenger
    end
  end

  describe "validations" do
    it "must have a date" do
      new_trip = @trip
      new_trip.date = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a cost" do
      new_trip = @trip
      new_trip.cost = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end

    it "may not have a rating greater than 5" do
      new_trip = @trip
      new_trip.rating = 7

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be between 1 and 5"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "convert_cost_to_dollars" do
      it "accurately converts cost from cents to dollars" do
        @trip.save
        trip = Trip.find_by(id: @trip.id)

        expect(trip.cost_to_dollars).must_be_close_to 7.40, 0.01
      end
    end

  end
end
