require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  before do
    @driver = Driver.create(name: "Kari", vin: "123", active: true,
      car_make: "Cherry", car_model: "DR5")
  end

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      Driver.destroy_all

      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      existing_driver = Driver.find_by(id: @driver.id)

      # Act
      get driver_path(existing_driver.id) 

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Act
      get driver_path(-1) 

      # Assert
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
      driver_hash = {
        driver: {
          name: "Cari", 
          vin: "1234", 
          active: true,
          car_make: "Ford", 
          car_model: "Escape"
        },
      }

      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      # Assert
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.car_make).must_equal driver_hash[:driver][:car_make]
      expect(new_driver.car_model).must_equal driver_hash[:driver][:car_model]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hashes = [
        {
          driver: {
            name: "",
            vin: ""
          },
        },
        {
          driver: {
            name: "      ",
            vin: "     "
          },
        },
        {
          driver: {
            name: nil,
            vin: nil
          }
        },
        {
          driver: {
            name: "Another Kari", 
            vin: "123"
          }
        },
        {
          driver: {
            car_make: "Hello"
          }
        }
      ]
      
      driver_hashes.each do |driver_data|
        expect {
          post drivers_path, params: driver_data
        }.must_differ "Driver.count", 0
      end

      must_respond_with :redirect
      must_redirect_to new_driver_path
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver_id = Driver.first.id

      get edit_driver_path(driver_id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      new_driver = Driver.create(
        name: "Margot", 
        vin: "2357", 
        active: true,
        car_make: "BMW", 
        car_model: ""
      )
      new_driver_id = new_driver.id
      p new_driver_id

      updated_driver_data = {
        driver: {
          name: "Margot", 
          vin: "2357", 
          active: true,
          car_make: "Tesla", 
          car_model: ""
        },
      }

      expect {
        patch driver_path(new_driver_id), params: updated_driver_data
      }.must_differ "Driver.count", 0

      expect(Driver.find_by(id: new_driver_id).car_make).must_equal updated_driver_data[:driver][:car_make]
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver_id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      updated_driver_data = {
        driver: {
          name: "Margot", 
          vin: "2357", 
          active: true,
          car_make: "Tesla", 
          car_model: ""
        },
      }

      expect {
        patch driver_path(-1), params: updated_driver_data
      }.must_differ "Driver.count", 0

      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_id = @driver.id
      updated_driver_data = {
        driver: {
          name: "", 
          vin: "", 
          active: true,
          car_make: "", 
          car_model: ""
        },
      }

      expect {
        patch driver_path(driver_id), params: updated_driver_data
      }.must_differ "Driver.count", 0

      must_respond_with :redirect
      must_redirect_to edit_driver_path
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      existing_driver = Driver.first
      existing_driver_id = existing_driver.id
      expect (Driver.count).must_equal 1

      expect {
        delete driver_path(existing_driver_id)
      }.must_differ "Driver.count", -1
      
      assert_nil (Driver.find_by(id: existing_driver_id))
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      invalid_id = -1
      expect (Driver.count).must_equal 1
      assert_nil (Driver.find_by(id: invalid_id))

      expect { delete driver_path(invalid_id) }.must_differ "Driver.count", 0

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
