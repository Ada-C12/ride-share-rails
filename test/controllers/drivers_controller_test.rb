require "test_helper"

describe DriversController do
  describe "index" do
    it "responds with success when there are many drivers saved" do
      Driver.create(name: "Tommy Salami", vin: "cat123")
      get drivers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers saved" do
      get drivers_path 
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      driver = Driver.create(name: "Tommy Salami", vin: "cat123")
      get driver_path(driver.id)
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
      get driver_path(567889832525)
      must_respond_with :not_found 
    end
  end
  
  describe "new" do
    it "responds with success" do
    end
  end
  
  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {
      driver: {name: "Tommy Salami", vin: "cat123"}
    }
    expect {
    post drivers_path, params: driver_hash
    }.must_differ "Driver.count", 1
  
    must_redirect_to drivers_path 
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
      driver: {name: " ", vin: "cat123"}
    }

    expect {
    post drivers_path, params: driver_hash
    }.must_differ "Driver.count", 0
    
    must_redirect_to drivers_path 
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver = Driver.create(name: "Tommy Salami", vin: "cat123")
      get edit_driver_path(driver.id)
      
      must_respond_with :success
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(976)
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      driver = Driver.create(name: "Tommy Salami", vin: "123cat")
      driver_hash = {driver: {name: "Felix Puppy", vin: "dog456"}}

      patch driver_path(id: driver.id), params: driver_hash
      updated_driver = Driver.find_by(id: driver.id)

      expect(updated_driver.name).must_equal driver_hash[:driver][:name] 
      expect(updated_driver.vin).must_equal driver_hash[:driver][:vin]

      must_redirect_to driver_path(driver.id) 
    end

      it "responds with a redirect for an invalid update" do
        driver = Driver.create(name: "Tommy Salami", vin: "123cat")
          bad_driver = {
          driver: {
          name: "",
          vin: "cool500"
          }
        }

        patch driver_path(id: driver.id), params: bad_driver
        updated_driver = Driver.find_by(id: driver.id)
        expect(updated_driver.name).must_equal "Tommy Salami"
        expect(updated_driver.vin).must_equal "123cat"
        must_redirect_to edit_driver_path     
      end

    it "can change driver status online" do 
      driver = Driver.create(name: "Kari", vin: "123")

    expect(driver.status).must_equal "available"
    end 

  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      driver = Driver.create(name: "Tommy Salami", vin: "123cat")

      expect {
      delete driver_path(id: driver.id) 
      }.must_differ 'Driver.count', -1
    end

    it "does not change the db when the driver does not exist, then responds with " do
      driver = Driver.create(name: "Bob", vin: "123cat")

      expect {
      delete driver_path(id: -2) 
      }.must_differ 'Driver.count', 0
    end
  end
end