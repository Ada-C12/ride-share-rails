require "test_helper"

describe Driver do
  it "can be instantiated" do
    # Assert
    new_driver = Driver.new(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver = Driver.new(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
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
      new_driver = Driver.new(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
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
      new_driver = Driver.new(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver = Driver.new(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "find_driver_trips" do
      it "returns all the trips from a specific driver" do
        passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
        driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
        trip = Trip.new(driver_id: driver.id, 
          passenger_id: passenger.id,
          date: Time.now,
          rating: nil,
          cost: 100,)

        trip.save

        expect(driver.find_driver_trips.count).must_equal 1
      end
    end

    describe "calculate_total_earnings" do
      it "returns the total amount a driver made" do
        passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
        driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
        trip = Trip.new(driver_id: driver.id, 
          passenger_id: passenger.id,
          date: Time.now,
          rating: nil,
          cost: 100,)

        trip.save

        expect(driver.calculate_total_earnings).must_equal 78.68
      end
    end


    describe "calculate_average_rating" do
      it "returns a driver's average rating" do
        driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
        passenger_1 = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
        trip_1 = Trip.new(driver_id: driver.id, 
          passenger_id: passenger_1.id,
          date: Time.now,
          rating: 5,
          cost: 100,)
        trip_1.save

        passenger_2 = Passenger.create(name: "Kristina", phone_num: "757-111-1281")
        trip_2 = Trip.new(driver_id: driver.id, 
          passenger_id: passenger_2.id,
          date: Time.now,
          rating: 4,
          cost: 100,)

        trip_2.save

        expect(driver.calculate_average_rating).must_equal 4.5
      end
    end

    describe "find_available_driver" do
      it "will find a driver that is available" do
        driver_1 = Driver.create(name: "Milly Bobbie Brown", vin: "10000023", active: true, car_make: "Cherry", car_model: "DR5")
        driver_2 = Driver.create(name: "Elvis Presley", vin: "1212323", active: false, car_make: "Cherry", car_model: "DR5")

        expect(Driver.find_available_driver).must_equal driver_1.id
      end
    end
  end
end
