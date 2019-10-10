require "test_helper"

describe DriversController do

  describe "index" do
    it "responds with success when there are many drivers saved" do
      new_driver = Driver.create name: "Random name", vin: "XFHJKDHSLFKJDKL", available: true

      get drivers_path

      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @driver = Driver.create name: "Random name", vin: "XFHJKDHSLFKJDKL", available: true
    end

    it "responds with success when showing an existing valid driver" do
      get driver_path(@driver.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      invalid_id = -1

      get driver_path(invalid_id)

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
      driver_hash = {
        driver: {
          name: "Bob's Burgers",
          vin: "FDJSKFJD84938",
          available: true,
        },
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])

      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          vin: "FDJSKFJD84938",
          available: true,
        },
      }

      expect {
        post drivers_path, params: driver_hash
      }.wont_change "Driver.count"

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved

      @driver = Driver.create name: "Random name", vin: "XFHJKDHSLFKJDKL", available: true

      # Act
      get edit_driver_path(@driver.id)

      # Assert
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
      existing_driver = Driver.create name: "Harry Potter", vin: "HOGWA4RT$"

      updated_driver_hash = {
        driver: {
          name: "Ron Weasley",
          vin: "ASDASDKJ456",
        },
      }

      expect {
        patch driver_path(existing_driver.id), params: updated_driver_hash
      }.wont_change "Driver.count"

      updated_driver = Driver.find_by(id: existing_driver.id)

      expect(updated_driver.name).must_equal updated_driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal updated_driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(updated_driver)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      updated_driver_hash = {
        driver: {
          name: "Ron Weasley",
          vin: "ASDASDKJ456",
        },
      }

      invalid_driver_id = -1

      patch driver_path(invalid_driver_id), params: updated_driver_hash

      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      existing_driver = Driver.create name: "Harry Potter", vin: "HOGWA4RT$"
      updated_driver_hash = {
        driver: {
          name: "Ron Weasley",
        },
      }

      expect {
        patch driver_path(existing_driver.id), params: updated_driver_hash
      }.wont_change "Driver.count"

      driver_id = Driver.find_by(id: existing_driver.id)

      must_respond_with :redirect
      must_redirect_to driver_path(driver_id)
    end
  end

  describe "destroy" do
    before do
      @driver_to_be_deleted = Driver.create!(name: "Freddy Krueger", vin: "ASDJ2343")
    end

    it "destroys the driver instance in db when driver exists, then redirects" do
      expect {
        delete driver_path(@driver_to_be_deleted.id)
      }.must_change "Driver.count", 1

      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      invalid_driver_id = -1

      delete driver_path(invalid_driver_id)

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "can change driver status" do
    before do
      @new_driver = Driver.create!(name: "Ghost Driver", vin: "ASDJ2343")
    end

    it "can go online" do
      @new_driver.update(available: false)

      patch make_available_path(@new_driver.id)

      expect((Driver.find(@new_driver.id)).available).must_equal true
      must_respond_with :redirect
      must_redirect_to driver_path(@new_driver.id)
    end

    it "can go offline" do
      @new_driver.update(available: true)

      patch make_unavailable_path(@new_driver.id)

      expect((Driver.find(@new_driver.id)).available).must_equal false
      must_respond_with :redirect
      must_redirect_to driver_path(@new_driver.id)
    end

    it "if driver not specified, redirects to drivers list" do
      invalid_driver_id = -1

      patch make_available_path(invalid_driver_id)

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

end
