require "test_helper"
require "pry"

describe DriversController do
  # tried to refactor using let but tests were not working and could not figure out what was wrong
  # let (:driver) {
  #   Driver.create(name: "Kari", vin: "123")
  # }

  describe "index" do
    it "responds with success when there are many drivers saved" do
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
      existing_driver = Driver.create(name: "Kari", vin: "123")
      get driver_path(existing_driver.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get driver_path(777)

      must_redirect_to nope_path
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

      must_redirect_to driver_path(Driver.find_by(name: driver_hash[:driver][:name]))
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do

      new_driver_hash = {
        driver: {
          name: "",
          vin: "123"
        }
      }
      
      expect {
        post drivers_path, params: new_driver_hash
      }.must_differ 'Driver.count', 0

      must_redirect_to nope_path
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      existing_driver = Driver.create(name: "Kari", vin: "123")
      get edit_driver_path(existing_driver.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(777)

      must_redirect_to root_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      existing_driver = Driver.create(name: "Kari", vin: "123")
      updated_driver_data = {
        driver: {
          name: "Not Kari haha",
          vin: "987"
        }
      }
      
      expect {
        patch driver_path(id: existing_driver.id), params: updated_driver_data
      }.must_differ 'Driver.count', 0
      
      
      patch driver_path(id: existing_driver.id), params: updated_driver_data
      updated_driver = Driver.find_by(id: existing_driver.id)
      expect(updated_driver.name).must_equal updated_driver_data[:driver][:name]
      expect(updated_driver.vin).must_equal updated_driver_data[:driver][:vin]

      expect(updated_driver.valid?).must_equal true
      
      must_redirect_to driver_path(updated_driver.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      patch driver_path(777)
      must_redirect_to nope_path
    end

    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
      existing_driver = Driver.create(name: "Kari", vin: "123")
      updated_driver_data = {
        driver: {
          name: "",
          vin: "",
          active: false,
        }
      }
      
      patch driver_path(id: existing_driver.id), params: updated_driver_data

      updated_driver = Driver.find_by(id: existing_driver.id)

      expect(updated_driver.name).must_equal existing_driver.name
      expect(updated_driver.vin).must_equal existing_driver.vin
      expect(updated_driver.active).must_equal existing_driver.active
      
      must_redirect_to nope_path
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      existing_driver = Driver.create(name: "Mark", vin: "776")
      expect {
        delete driver_path(existing_driver.id)
      }.must_differ "Driver.count", -1

      must_redirect_to driver_path

    end

    it "does not change the db when the driver does not exist, then responds with " do

      expect {
        delete driver_path(777)
      }.must_differ "Driver.count", 0

      must_redirect_to nope_path
    end
  end

  describe "active" do
    it "should mark driver.active to true or false" do
      driver = Driver.create(name: "Kari", vin: "123")

      updated_active_status = {
        driver: {
          active: true
        }
      }
      patch driver_active_path(driver.id), params: updated_active_status
      
      updated_driver = Driver.find_by(id:driver.id)
      
      expect(updated_driver.active).must_equal true
      must_redirect_to driver_path(driver.id)
    end 
  end
end
