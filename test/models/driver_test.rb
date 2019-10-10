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
    let (:driver) {
      Driver.create(name: "Driver", vin: "123", active: nil)
    }

    let(:passenger) {
      Passenger.create(name: "Haha Me", phone_num: "Nonono")
    }

    let(:trip_1) {
      Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "1000", rating: "5")
    }

    let(:trip_2) {
      Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, cost: "2000", rating: "4")
    }

    describe "average rating" do
      # Your code here
      it "can calculate the average rating of this driver when the driver made at least one trip" do
        average_rating = ((trip_1.rating.to_i + trip_2.rating.to_i).to_f / 2).round(2)
        driver.save
        passenger.save

        expect(driver.average_rating).must_equal average_rating
      end

      it "will return 0 if the driver did not take any trip" do
        driver.save
        passenger.save
        Trip.destroy_all

        expect(driver.average_rating).must_equal 0
      end
    end

    describe "total earnings" do
      # Your code here
      it "can calculate the total earning of this driver when the driver made at least one trip" do
        total_earning = ((trip_1.cost.to_i - 1.65) * 0.8 + (trip_2.cost.to_i - 1.65) * 0.8).round(2)
        driver.save
        passenger.save

        expect(driver.total_earning).must_equal total_earning
      end

      it "will return 0 if the driver did not take any trip" do
        driver.save
        passenger.save
        Trip.destroy_all

        expect(driver.total_earning).must_equal 0
      end
    end

    describe "can go online" do
      # Your code here
      it "can switch the active status of driver to nil which means the driver is available to accept a trip" do
        driver.update(active: true)
        expect(driver.active).must_equal true
        driver.go_online

        find_driver = Driver.find_by(id: driver.id)
        expect(find_driver.active).must_be_nil
      end
    end

    describe "can go offline" do
      # Your code here
      it "can switch the active status of driver to true which means the driver is not available to accept a trip" do
        driver.save
        expect(driver.active).must_be_nil
        driver.go_offline

        find_driver = Driver.find_by(id: driver.id)
        expect(find_driver.active).must_equal true
      end
    end

    # You may have additional methods to test
  end
end
