require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  let(:driver) {
    Driver.create(name: "me driver", vin: "ada2019")
  }

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      # Act
      driver.save
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      # Act
      get driver_path("-1")
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
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Hello Driver",
          vin: "987654321",
        },
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 1
      # Check that the controller redirected the user
      must_redirect_to driver_path(Driver.find_by(name: "Hello Driver"))
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      # Act-Assert
      # Ensure that there is no change in Driver.count
      # Assert
      expect {
        post drivers_path, params: { driver: { name: "", vin: "" } }
      }.must_differ "Driver.count", 0
      # Check that the controller redirected the user
      assert_template :new
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver.save
      # Act
      get edit_driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Act
      get edit_driver_path(-1)
      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      driver.save
      new_hash = {
        name: "Driver Me",
        vin: "2019ada",
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: { driver: new_hash }
      }.must_differ "Driver.count", 0

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      find_driver = Driver.find_by(id: driver.id)
      expect(find_driver.name).must_equal new_hash[:name]
      expect(find_driver.vin).must_equal new_hash[:vin]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(find_driver.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      driver.save
      pre_name = driver.name
      pre_vin = driver.vin
      new_hash = {
        name: "Driver Me",
        vin: "2019ada",
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(-1), params: { driver: new_hash }
      }.must_differ "Driver.count", 0

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver.save
      new_hash = {
        name: "",
        vin: "",
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver.id), params: { driver: new_hash }
      }.must_differ "Driver.count", 0

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver.save

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_differ "Driver.count", -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      driver.save

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(-1)
      }.must_differ "Driver.count", 0

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end

  describe "toggle_activate" do
    it "changes driver's status to available when clicking the button and redirect" do
      driver.update(active: true)
      find_driver = Driver.find_by(id: driver.id)
      expect(find_driver.active).must_equal true

      patch activate_path(driver.id)

      find_driver_again = Driver.find_by(id: driver.id)
      expect(find_driver_again.active).must_be_nil
      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "doesn't change the driver's status if giving an invalid id and redirect" do
      driver.update(active: true)
      find_driver = Driver.find_by(id: driver.id)
      expect(find_driver.active).must_equal true

      patch activate_path(-1)

      find_driver_again = Driver.find_by(id: driver.id)
      expect(find_driver_again.active).must_equal true
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "toggle_deactivate" do
    it "changes driver's status to unavailable when clicking the button and redirect" do
      driver.save
      find_driver = Driver.find_by(id: driver.id)
      expect(find_driver.active).must_be_nil

      patch deactivate_path(driver.id)

      find_driver_again = Driver.find_by(id: driver.id)
      expect(find_driver_again.active).must_equal true
      must_respond_with :redirect
      must_redirect_to driver_path(driver.id)
    end

    it "doesn't change the driver's status if giving an invalid id and redirect" do
      driver.save
      find_driver = Driver.find_by(id: driver.id)
      expect(find_driver.active).must_be_nil

      patch deactivate_path(-1)

      find_driver_again = Driver.find_by(id: driver.id)
      expect(find_driver_again.active).must_be_nil
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
end
