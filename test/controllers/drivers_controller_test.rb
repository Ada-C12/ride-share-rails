require "test_helper"

describe DriversController do
  
  describe "index action" do
    let (:driver) {
      Driver.create name: "George", vin: "123456789"
    }
    
    it "responds with success when there are many drivers in the database" do
      driver
      get drivers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers in the database" do
      driver.destroy
      
      get drivers_path
      
      must_respond_with :success
    end
  end
  
  
  describe "show action" do
    let (:driver) {
      Driver.create name: "Wallis", vin: "987654321"
    }
    
    it "responds with success when showing an existing valid driver" do
      get driver_path(driver.id)
      
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
      
      get driver_path(-1)
      
      must_respond_with :missing
    end
  end
  
  
  describe "new action" do
    
    it "responds with success" do
      get new_driver_path
      
      must_respond_with :success
    end
  end
  
  describe "create action" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {
        driver: {
          name: "SpongeBob", 
          vin: "1234567890"
        }
      }
      
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1
      
      must_redirect_to driver_path(Driver.find_by(name: "SpongeBob"))
    end
  end
  
  describe "edit action" do
    let (:driver) {
      Driver.create name: "Patrick Star", vin: "9876543210"
    }
    
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(driver)
      
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    let (:driver) {
      Driver.create name: "Sammy Sam", vin: "235320"
    }
    
    it "can update an existing driver with valid information accurately, and redirect" do
      driver_hash = {
        driver: {
          name: "Spammy Spam",
          vin: "000000"
        }
      }
      
      patch driver_path(driver.id), params: driver_hash
      
      updated_driver = Driver.find_by(id: driver.id)
      expect(updated_driver.name).must_equal driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal driver_hash[:driver][:vin]
      
      must_respond_with :redirect
      must_redirect_to drivers_path(driver)
      
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      
      patch driver_path(-1)
      must_respond_with :redirect
      
    end
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      count = Driver.count
      new_driver = Driver.create name: "Spammy Spam", vin: "007700"
      
      # Ensure there is an existing driver saved
      expect(Driver.count).must_equal (count + 1)
      
      expect{
        delete driver_path(new_driver.id)
      }.must_change "Driver.count", 1
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
    
    it "does not change the db when the driver does not exist " do
      
      before_count = Driver.count
      delete driver_path(-1)
      after_count = Driver.count
      expect(before_count).must_equal after_count
    end
  end
end

