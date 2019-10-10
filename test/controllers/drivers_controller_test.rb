require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver) {
    Driver.create(name: "sample driver", vin: "a sample vin", active: false)
  }
  
  describe "index" do
    it "responds with success when there is at least one Driver saved" do
      Driver.create(name: "test driver", vin: "test vin")
      
      get drivers_path
      
      must_respond_with :success
      expect(Driver.count).must_be :>, 0
    end
    
    it "responds with success when there are no drivers saved" do
      get drivers_path
      
      must_respond_with :success
      expect(Driver.count).must_equal 0
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      get driver_path(driver.id)
      
      must_respond_with :success
      expect(Driver.count).must_be :>, 0
    end
    
    it "responds with 404 with an invalid driver id" do
      get driver_path(-20)
      
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
          name: "new driver",
          vin: "new vin"
        }
      }
      
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
      
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a render of new driver page" do
      assert Driver.create(name: "", vin: "new vin").valid? == false
      
      expect(Driver.count).must_equal 0
      
      driver_hash = {
        driver: {
          name: "",
          vin: "new vin"
        }
      }
      
      post drivers_path, params: driver_hash
      must_respond_with :success
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(driver.id)
      
      must_respond_with :success
      expect(Driver.count).must_be :>, 0
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-20)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      driver_hash = { 
        driver: { 
          name: "Updated name",
          vin: "Updated vin"
        }
      }
      
      driver_to_update = driver
      
      expect {
        patch driver_path(driver_to_update.id), params: driver_hash
      }.must_differ "Driver.count", 0
      
      updated_driver = Driver.find_by(id: driver.id)
      
      expect(updated_driver.name).must_equal driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal driver_hash[:driver][:vin]
      
      must_respond_with :redirect
      must_redirect_to driver_path
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      driver_hash = { 
        driver: { 
          name: "Updated name",
          vin: "Updated vin"
        }
      }
      
      expect {
        patch driver_path(-20), params: driver_hash
      }.must_differ "Driver.count", 0
      
      must_respond_with :not_found
    end
    
    it "does not update a driver if the form data violates Driver validations, and responds with a render of current page" do
      driver_hash = { 
        driver: { 
          name: "",
          vin: "Updated vin"
        }
      }
      
      driver_to_update = driver
      
      expect {
        patch driver_path(driver_to_update.id), params: driver_hash
      }.must_differ "Driver.count", 0
      
      must_respond_with :success
      
      validity = driver_to_update.update(name: "", vin: "updated vin")
      
      expect(validity).must_equal false
    end
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      id_to_delete = driver.id
      
      expect {
        delete driver_path(id_to_delete)
      }.must_differ "Driver.count", -1
      
      removed_driver = Driver.find_by(id: driver.id)
      removed_driver.must_be_nil
      
      must_redirect_to drivers_path
    end
    
    it "does not change the db when the driver does not exist, then responds with redirect" do
      nonexistent_id = -20
      
      expect {
        delete driver_path(nonexistent_id)
      }.must_differ "Driver.count", 0
      
      must_redirect_to drivers_path
    end
    
    it "will redirect to driver index page if driver was already deleted" do
      id_to_delete = driver.id
      Driver.destroy_all
      
      expect {
        delete driver_path(id_to_delete)
      }.must_differ "Driver.count", 0
      
      must_redirect_to drivers_path
    end
  end
end
