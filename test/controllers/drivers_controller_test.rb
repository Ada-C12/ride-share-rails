require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver) {
    Driver.create name: "Bernardo Prosacco",
                  vin: "WBWSS52P9NEYLVDE9"
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      get drivers_path
      must_respond_with :success
      # Assert
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      get driver_path(driver.id)
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get driver_path(-1)
      must_respond_with :not_found
      # Assert
    end
  end

  describe "new" do
    it "responds with success, can get the new driver page" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do

      driver_hash = {
        driver: {
          name: "Bernardo Prosacco",
          vin: "WBWSS52P9NEYLVDE9"
        },
      }
      
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do

      invalid_id = -1
      get edit_driver_path(invalid_id)
      must_respond_with :redirect
      must_redirect_to driver_path
      # Assert
      # Check that the controller redirects
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
        edit_driver_path(driver.id)
      # Act
        must_respond_with :success
      # Assert

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
        invalid_id = -100
      # Act
        get edit_driver_path(invalid_id)
      # Assert
        must_redirect_to driver_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      input_driver = Driver.create(name: "Input driver", vin: "1111111111")
      input_updates = {driver: {name: "Updated driver", vin: "2222222222"}}

      patch driver_path(input_driver), params: input_updates

      input_driver.reload
      expect(input_driver.name).must_equal "Updated driver"

      # Act-Assert
      # Ensure that there is no change in Driver.count
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      get driver_path(-1)
      must_respond_with :redirect
      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller gave back a 404

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects

    end
  end

  describe "destroy" do
    it "successfully deletes an existing driver and then redirects to list of drivers at drivers index" do
        Driver.create(name: "Input driver", vin: "1111111111")
        existing_driver_id = Driver.find_by(name: "Input driver").id
  
        expect {
          delete driver_path( existing_driver_id )
        }.must_differ "Driver.count", -1
  
        must_redirect_to drivers_path
      end
  end

    it "does not change the db when the driver does not exist, then responds with " do
    #   # Arrange
    #   # Ensure there is an invalid id that points to no driver
    driver.save

    expect {
      delete driver_path(-1)
    }.must_differ "Driver.count", 0

    must_respond_with :redirect
 end
  
    end
  end
