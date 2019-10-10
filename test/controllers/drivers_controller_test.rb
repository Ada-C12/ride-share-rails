require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      Driver.create(vin: "abcdefgvin", name: "geli driver")

      # Act
      get drivers_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
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
      # Ensure that there is a driver saved
      new_driver = Driver.create(vin: "abcdefgvin", name: "geli driver")

      # Act
      get driver_path(new_driver.id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      new_driver = Driver.create(vin: "abcdefgvin", name: "geli driver")
      new_driver_id = new_driver.id
      assert_not_nil(Driver.find_by(id: new_driver_id))
      # destroy new driver
      Driver.find_by(id: new_driver.id).destroy
      assert_nil(Driver.find_by(id: new_driver_id))

      # Act
      get driver_path(new_driver_id)

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
      new_driver_params = { driver: {
        name: "Saint Goodname", 
        vin: "validvin023"}
      }

      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect{post drivers_path, params: new_driver_params}.must_differ "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: new_driver_params[:driver][:name])
      expect(new_driver.vin).must_equal new_driver_params[:driver][:vin]
      expect(new_driver.active).must_equal false

      # Check that the controller redirected the user
      must_redirect_to driver_path(new_driver.id)

    end

    it "does not create a driver if the form data violates Driver validations, and responds by re-rendering the new view and setting status to 422" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      bad_new_driver_params = [
        {
          driver: {
            name: "Name ButNoVIN", 
            vin: ""
          }
        },
        {
          driver: {
            name: "",
            vin: "VIN ButNoName"
          }
        }
      ]

      # Act-Assert
      # Ensure that there is no change in Driver.count
      bad_new_driver_params.each do |bad_params|
        expect{post drivers_path, params: bad_params}.must_differ "Driver.count", 0
      end

      # Assert
      # Check that the controller re-renders the new view and sets status to ::unprocessable_entity
      assert_response :unprocessable_entity
      
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      new_driver = Driver.create(vin: "abcdefgvin", name: "geli driver")
      assert_not_nil(Driver.find_by(id: new_driver.id))

      # Act
      get edit_driver_path(new_driver.id)

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      new_driver = Driver.create(vin: "abcdefgvin", name: "geli driver")
      new_driver_id = new_driver.id
      assert_not_nil(Driver.find_by(id: new_driver_id))
      # destroy new driver
      Driver.find_by(id: new_driver.id).destroy
      assert_nil(Driver.find_by(id: new_driver_id))

      # Act
      get edit_driver_path(new_driver_id)

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      new_driver = Driver.create(name: "Geli Driver", vin: "abcdefgvin")
      new_driver_id = new_driver.id
      assert_not_nil(new_driver_id)

      edit_driver_params = { driver: {
        name: "Saint Geli", 
        vin: "validervin023"}
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{patch driver_path(new_driver_id), params: edit_driver_params}.must_differ "Driver.count", 0

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      expect(Driver.find_by(id: new_driver_id).name).must_equal edit_driver_params[:driver][:name]
      expect(Driver.find_by(id: new_driver_id).vin).must_equal edit_driver_params[:driver][:vin]


    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      invalid_id = -1
      assert_nil(Driver.find_by(id: invalid_id))
      edit_driver_params = { driver: {
        name: "Saint Geli", 
        vin: "validervin023"}
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{patch driver_path(invalid_id), params: edit_driver_params}.must_differ "Driver.count", 0

      # Assert
      # Check that the controller gave back a 404
      assert_response :not_found

    end

    it "does not update a driver if the form data violates Driver validations, and responds by re-rendering the edit view and setting status to 422" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      existing_driver = Driver.create(name: "Geli Gel", vin: "validvin023")
      existing_driver_id = existing_driver.id
      assert_not_nil(existing_driver_id)

      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      bad_edit_driver_params = [
        {
          driver: {
            name: "Name ButNoVIN", 
            vin: ""
          }
        },
        {
          driver: {
            name: "",
            vin: "VIN ButNoName"
          }
        }
      ]

      # Act-Assert
      # Ensure that there is no change in Driver.count
      bad_edit_driver_params.each do |bad_params|
        expect{patch driver_path(existing_driver.id), params: bad_params}.must_differ "Driver.count", 0
      end

      # Assert
      # Check that the controller renders edit view and sets status to 422
      assert_response :unprocessable_entity

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      existing_driver = Driver.create(name: "Geli Gel", vin: "validvin023")
      existing_driver_id = existing_driver.id
      assert_not_nil(existing_driver_id)
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect{delete driver_path(existing_driver_id)}.must_differ "Driver.count", -1

      # Assert
      # Check that the controller redirects
      must_redirect_to drivers_path

    end

    it "does not change the db when the driver does not exist, then responds with redirect to drivers index" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1
      assert_nil(Driver.find_by(id: invalid_id))

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{delete driver_path(invalid_id)}.must_differ "Driver.count", 0

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_redirect_to drivers_path

    end
  end

  describe "toggle_active" do
    it "changes a new driver's 'inactive' value from default 'false' to 'true' and redirects to drivers path" do
      # Arrange
      new_inactive_driver = Driver.create(name: "Geli Gel", vin: "validvin023")
      new_inactive_driver_id = new_inactive_driver.id
      assert_not_nil(new_inactive_driver_id)
      expect(new_inactive_driver.active).must_equal false
      test_params = {
        id: new_inactive_driver_id
      }

      # Act
      patch toggle_active_path(new_inactive_driver_id), params: test_params

      # Assert
      expect(Driver.find_by(id: new_inactive_driver_id).active).must_equal true
      must_respond_with :success

    end
    it "changes an active driver's :active value from 'true' to 'false' and redirects to drivers path" do
      # Arrange
      active_driver = Driver.create(name: "Geli Gel", vin: "validvin023", active: true)
      active_driver_id = active_driver.id
      assert_not_nil(active_driver_id)
      expect(Driver.find_by(id: active_driver_id).active).must_equal true
      test_params = {
        id: active_driver_id
      }

      # Act
      # Toggle from True to False
      patch toggle_active_path(active_driver_id), params: test_params
      
      # Assert
      expect(Driver.find_by(id: active_driver_id).active).must_equal false
      must_respond_with :success

    end
  end
end
