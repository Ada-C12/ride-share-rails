require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", active: true,
               car_make: "Cherry", car_model: "DR5")
  }

  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :active, :car_make, :car_model].each do |field|

      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      driver = Driver.first

      # Assert
      expect(driver.trips.count).must_be :>=, 0
      driver.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @driver = Driver.create(
        name: "Sarah",
        vin: "848485859",
        car_make: "Ford",
        car_model: "Escape",
        active: true
      )
      @passenger = Passenger.create(name: "Jane", phone_num: "12345678")

      Trip.create(
        date: "10-09-2019",
        rating: 3,
        cost: 2040,
        passenger_id: @passenger.id,
        driver_id: @driver.id
      )

      Trip.create(
        date: "09-09-2019",
        rating: 5,
        cost: 2540,
        passenger_id: @passenger.id,
        driver_id: @driver.id
      )

    end

    describe "average rating" do
      it "can calculate the correct average rating for a driver" do
        expect(Trip.count).must_equal 2
        average_rating = ((Trip.all.map {|trip| trip.rating}.sum).to_f / Trip.count).round(1)

        expect(@driver.average_rating).must_equal average_rating
      end

      it "returns nil if valid driver doesn't have any trip" do  
        driver = Driver.create(name: "Harry", vin: "0987") 
        assert_nil (driver.average_rating)
      end
    end

    describe "total earnings" do
      # Your code here
    end

    describe "can go online" do
      # Your code here
    end

    describe "can go offline" do
      # Your code here
    end

    # You may have additional methods to test
  end
end
