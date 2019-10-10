require "test_helper"

describe DriversController do

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      Driver.create name: "Number One Benitez", vin: 53246, active: false, car_make: "Toyota", car_model: "Tacoma"
      Driver.create name: "Fred Boutros", vin: 32960, active: true, car_make: "Volkswagen", car_model: "Eurovan"
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      @fred = Driver.create name: "Fred Boutros", vin: 32960, active: true, car_make: "Volkswagen", car_model: "Eurovan"
      delete driver_path(@fred.id)
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      @mb = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      # Ensure that there is a driver saved
      if Driver.count != 1
        puts 'No driver saved'
      end
      # Act
      get driver_path(@mb.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do

      get driver_path(99999)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Number One Benitez",
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Ensure that there is a change of 1 in Driver.count
      # Assert
      number_one = Driver.find_by(name: driver_hash[:driver][:name])
      expect(number_one.vin).must_equal driver_hash[:driver][:vin]
      expect(number_one.active).must_equal driver_hash[:driver][:active]
      expect(number_one.car_make).must_equal driver_hash[:driver][:car_make]
      expect(number_one.car_model).must_equal driver_hash[:driver][:car_model]
      must_respond_with :redirect
      must_redirect_to driver_path(number_one.id)
    end

    it "does not create a driver if the form data violates Driver validations" do
      driver_hash = {
        driver: {
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
      expect {
        post drivers_path, params: driver_hash
      }.wont_change Driver.count
    end
  end

  describe "edit" do
    before do
      @mb = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      @driver_hash = {
        driver: {
          name: "Barbara Bush",
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
    end
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(@mb)
      must_respond_with :success
    end

    it "responds with not found when getting the edit page for a non-existing driver" do
      get driver_path(9999)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      @mb = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      driver_hash = {
        driver: {
          name: "Barbara Bush",
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
      expect {patch driver_path(@mb.id), params: driver_hash}.wont_change Driver.count
      expect {
        patch driver_path(@mb.id), params: driver_hash
      }.must_respond_with :redirect

      expect {patch driver_path(@mb.id), params: driver_hash}.wont_change Driver.count
      expect(@mb.name).must_equal driver_hash[:driver][:name]
      expect(@mb.vin).must_equal driver_hash[:driver][:vin]
      expect(@mb.active).must_equal driver_hash[:driver][:active]
      expect(@mb.car_make).must_equal driver_hash[:driver][:car_make]
      expect(@mb.car_model).must_equal driver_hash[:driver][:car_model]
    end
  end

  it "does not update any driver if given an invalid id, and responds with a 404" do
    driver_hash = {
      driver: {
        name: "Barbara Bush",
        vin: "53246",
        active: false,
        car_make: "Toyota",
        car_model: "Tacoma"
      }
    }
    expect {
      patch driver_path(99999), params: driver_hash
    }.wont_change "Driver.count"
    must_redirect_to drivers_path
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      num_one = Driver.create name: "Number One Benitez", vin: 53246, active: false, car_make: "Toyota", car_model: "Tacoma"

      expect { delete driver_path(num_one.id) }.must_change 'Driver.count', -1

      deleted_driver = Driver.find_by(id: num_one.id)
      expect(deleted_driver).must_be_nil
      must_respond_with :redirect
    end

    it "does not change the db when the driver does not exist, then responds with not found" do
      delete driver_path(-1)
      must_respond_with :not_found
    end
  end
end
