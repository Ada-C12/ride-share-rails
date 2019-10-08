require "test_helper"
require "pry"

describe DriversController do

  describe "index" do
    it "responds with success when there are many drivers saved" do
      driver = Driver.create(name: "Kari", vin: "123")
      
      get drivers_path
     
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      Driver.destroy_all
      
      get drivers_path
      
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      driver = Driver.create(name: "Kari", vin: "123")
      get driver_path(driver.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get driver_path("40504")

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      @driver = Driver.new
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {
        driver: {
          name: "Home Dawg",
          vin: "098"
        }
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1

      must_redirect_to driver_path(Driver.find_by(name: "Home Dawg"))
    end

    # it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects
    # end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver = Driver.create(name: "Kari", vin: "123")
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path("40504")

      must_redirect_to root_path
    end
  end

  # describe "update" do
  #   it "can update an existing driver with valid information accurately, and redirect" do
  #     # Arrange
  #     # Ensure there is an existing driver saved
  #     # Assign the existing driver's id to a local variable
  #     # Set up the form data

  #     # Act-Assert
  #     # Ensure that there is no change in Driver.count

  #     # Assert
  #     # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
  #     # Check that the controller redirected the user

  #   end

  #   it "does not update any driver if given an invalid id, and responds with a 404" do
  #     # Arrange
  #     # Ensure there is an invalid id that points to no driver
  #     # Set up the form data

  #     # Act-Assert
  #     # Ensure that there is no change in Driver.count

  #     # Assert
  #     # Check that the controller gave back a 404

  #   end

  #   it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
  #     # Note: This will not pass until ActiveRecord Validations lesson
  #     # Arrange
  #     # Ensure there is an existing driver saved
  #     # Assign the existing driver's id to a local variable
  #     # Set up the form data so that it violates Driver validations

  #     # Act-Assert
  #     # Ensure that there is no change in Driver.count

  #     # Assert
  #     # Check that the controller redirects

  #   end
  # end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      existing_driver = Driver.create(name: "Mark", vin: "776")

      expect {
        delete driver_path(existing_driver.id)
      }.must_differ "Driver.count", -1

      must_redirect_to driver_path

    end

    it "does not change the db when the driver does not exist, then responds with " do
      invalid_id = 600

      expect {
        delete driver_path(invalid_id)
      }.must_differ "Driver.count", 0

      must_redirect_to root_path
    end
  end
end
