require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      driver = Driver.create(name: "Kari", vin: "123")
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
      
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      
      # Act
      get drivers_path      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    let (:driver) {
      Driver.create(name: "Kari", vin: "123")
    }
    it "responds with success when showing an existing valid driver" do
      # Arrange
      id = driver.id      
      # Act
      get driver_path(id)
      # Assert
      must_respond_with :success      
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      id = "bad-id"      
      # Act
      get driver_path(id)
      # Assert
      must_respond_with 404      
    end
  end
  
  describe "new" do
    it "responds with success" do
    end
  end
  
  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_params = {
        driver: {
          name: "Bad Driver",
          vin: "1877KARS4KIDS"
        }
      }
      
      expect{ post drivers_path, params: driver_params }.must_differ "Driver.count", 1
      
      bad_driver = Driver.first
      expect(bad_driver.name).must_equal driver_params[:driver][:name]
      expect(bad_driver.vin).must_equal driver_params[:driver][:vin]
      
      must_respond_with :redirect
      must_redirect_to driver_path(bad_driver.id)      
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      new_driver = {
        driver: {
          vin: "VinWithNoName"
        }
      }
      
      expect{ post drivers_path, params: new_driver }.must_differ "Driver.count", 0
      
      # Assert
      # Check that the controller redirects
      must_respond_with :success # our controller does not redirect, it renders the same page with the errors displayed.
    end
  end
  
  describe "edit" do
    let (:new_driver) {
      Driver.create(name: "Kari", vin: "123")
    }
    it "responds with success when getting the edit page for an existing, valid driver" do
      new_driver
      
      
      get edit_driver_path(new_driver.id)
      must_respond_with :success      
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      bad_id = "bad-id"
      
      get edit_driver_path(bad_id)
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
  
  describe "update" do
    let (:new_driver) {
      Driver.create(name: "Kari", vin: "123")
    }
    
    it "can update an existing driver with valid information accurately, and redirect" do
      new_driver
      expect(Driver.first).must_equal new_driver
      id = new_driver.id
      updates = { name: "Vin Diesel" }
      
      expect{ patch driver_path(id), params: {driver: updates}}.must_differ "Driver.count", 0
      
      new_driver.reload
      updated_driver = Driver.find(id)
      
      expect(updated_driver.name).must_equal new_driver.name
      
      must_redirect_to driver_path(id)
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      
      bad_id = "bad-id"
      updates = { name: "Vin Diesel" }
      
      expect{ patch driver_path(bad_id), params: {driver: updates}}.must_differ "Driver.count", 0
      
      must_respond_with 404
    end
    
    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      driver = new_driver
      updates = { name: "Vin Diesel", vin: nil }
      
      expect{ patch driver_path(driver.id), params: {driver: updates}}.must_differ "Driver.count", 0
      
      must_respond_with :success # our controller does not redirect, it renders the same page with the errors displayed.
      driver.reload
      expect(driver.vin).must_equal new_driver.vin      
      
    end
  end
  
  describe "destroy" do
    let (:new_driver) {
      Driver.create(name: "Kari", vin: "123")
    }
    it "destroys the driver instance in db when driver exists, then redirects" do
      expect(new_driver).must_be_instance_of Driver
      
      expect {
        delete driver_path( new_driver.id )
      }.must_differ "Driver.count", -1
      
      must_redirect_to drivers_path
    end
    
    it "does not change the db when the driver does not exist, then responds with " do
      bad_id = "bad-id"
      
      expect {
        delete driver_path( bad_id )
      }.must_differ "Driver.count", 0
      
      must_redirect_to drivers_path      
      
    end
  end
  
  describe "custom methods" do
    describe "can go online" do
      it "sets a new driver to inactive" do
        driver = Driver.create(name: "Rideshare Driver", vin: "5678")
        
        expect(driver.active).must_equal false
      end
    end
    
    describe "can go offline" do
      it "sets a driver to active" do
        driver = Driver.create(name: "Rideshare Driver", vin: "5678")
        id = driver.id
        
        expect{ patch driver_status_path(id) }.must_differ "Driver.count", 0
        must_redirect_to driver_path(id)
        
        driver.reload
        
        expect(driver.active).must_equal true
      end
    end
  end
end
