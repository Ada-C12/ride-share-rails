require "test_helper"

describe DriversController do
  
  before do
    @driver = Driver.create(name: "Sandi Toksvig", vin: "BD51 SM432J")
  end
  
  describe "index" do
    
    it "responds with success when there are many drivers saved" do
      
      get drivers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers saved" do
      
      Driver.destroy_all
      expect(Driver.count).must_equal 0
      
      get drivers_path
      must_respond_with :success
    end
    
  end
  
  describe "show" do
    
    it "responds with success when showing an existing valid driver" do
      get driver_path(@driver.id)
      must_respond_with :success
    end
    
    it "responds with redirect with an invalid driver ID" do 
      get driver_path(0)
      must_respond_with :redirect
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
      
      Driver.destroy_all
      expect(Driver.count).must_equal 0
      
      new_driver = {
        driver: {
          name: "Carmina Burana",
          vin: "F2Z0612TW34567",
        }
      }
      
      expect {
        post drivers_path, params: new_driver
      }
      .must_differ "Driver.count", 1
      created_driver = Driver.first 
      expect(created_driver.name).must_equal new_driver[:driver][:name]
      expect(created_driver.vin).must_equal new_driver[:driver][:vin]
      
      must_redirect_to driver_path(created_driver.id)
      
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      invalid_drivers = [
        {
          driver: {
            name: nil, 
            vin: "legit vin"
          },
        },
        { 
          driver: {
            name: "Quincy Jones", 
            vin: nil  
          },
        },
        {
          driver: {
            name: "",
            vin: "coolcoolvin"
          },
        },
        {
          driver: {
            name: "Quincy Jones",
            vin: ""
          }
        },
        {
          driver: {
            name: "       ",
            vin: "VinnyVinVinVin"
          },
        },
        {
          driver: {
            name: "Quincy Jones",
            vin: "      "
          }
        }
      ]
      
      invalid_drivers.each do |driver|
        expect {
          post drivers_path, params: driver
        }
        .must_differ "Driver.count", 0
      end
      
      must_respond_with :success      
      
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      driver_id = Driver.last.id
      
      get edit_driver_path(driver_id)
      
      must_respond_with :success    
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-5)
      must_respond_with :redirect
      must_redirect_to drivers_path    
    end
    
  end
  
  describe "update" do
    
    before do
      @to_update = {
        driver: {
          name: "Zaphod Beeblebrox",
          vin: "CoolGuy1"
        }
      }
    end
    
    it "can update an existing driver with valid information accurately, and redirects to updated driver page" do
      
      existing_driver = Driver.find_by(id: @driver.id)
      
      expect {
        patch driver_path(@driver.id), params: @to_update
      }.must_differ "Driver.count", 0
      
      updated_driver = Driver.find_by(id: @driver.id)
      expect(updated_driver.name).must_equal @to_update[:driver][:name]
      expect(updated_driver.vin).must_equal @to_update[:driver][:vin]
      
      must_respond_with :redirect
      must_redirect_to driver_path(@driver.id)
      
    end
    
    it "does not update driver if given an invalid id, and redirects to drivers list" do
      
      expect {
        patch driver_path(0), params: @to_update
      }.must_differ "Driver.count", 0
      must_redirect_to drivers_path
      
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      
      driver_id = @driver.id
      invalid_driver = {
        driver: {
          name: "", 
          vin: ""
        },
      }
      
      expect {
        patch driver_path(driver_id), params: invalid_driver
      }.must_differ "Driver.count", 0
      
      must_respond_with :success
      
    end
    
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects to driver list" do
      
      driver_to_remove = Driver.last
      
      expect {
        delete driver_path(driver_to_remove.id)
      }.must_differ "Driver.count", -1
      
      assert_nil (Driver.find_by(id: driver_to_remove.id))
      must_respond_with :redirect
      must_redirect_to drivers_path
      
    end
    
    it "does not change the db when the driver does not exist and respond with 'not found'" do
      
      expect {
        delete driver_path(0)
      }.must_differ "Driver.count", 0
      
      assert_nil (Driver.find_by(id: -99))
      must_respond_with :not_found
      
    end
  
  end
end

