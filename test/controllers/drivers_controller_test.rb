require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  describe "index" do
    it "responds with success when there are many drivers saved" do
      
      Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      driver = Driver.find_by(name: "Kari")
      
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
      @new_driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
    end
    
    it "responds with success when showing an existing valid driver" do
      
      driver = Driver.find_by(name: "Kari")
      get driver_path(driver.id)
      
      must_respond_with :success
      
    end
    
    it "responds with 404 with an invalid driver id" do
      
      get driver_path(-1)
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
      driver_hash = { driver: {
      name: "Jin",
      vin: "1234",
      car_make: "Honda",
      car_model: "Civic"}}
      
      expect {post drivers_path, params: driver_hash}.must_change "Driver.count", 1
      
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.car_make).must_equal driver_hash[:driver][:car_make]
      expect(new_driver.car_model).must_equal driver_hash[:driver][:car_model]
      
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
      
    end
    
    it "does not create a driver if the form data violates  Driver validations, and responds with a redirect" do
      
      driver_hash = { driver: {
      name: nil,
      vin: nil,
      car_make: nil}}
      
      expect {
      post drivers_path, params: driver_hash}.wont_change "Driver.count"
      
      must_respond_with :success
      
    end
  end
  
  describe "edit" do
    before do
      @edit_driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
    end
    it "responds with success when getting the edit page for an existing, valid driver" do
      
      get edit_driver_path(@edit_driver.id)
      
      must_respond_with :success
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      
      get edit_driver_path(-1)
      
      must_respond_with :redirect
      
    end
  end
  
  describe "update" do
    before do
      @driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      
      @updated_driver_hash = { 
      driver: {
      name: "Kari edit",
      vin: "123456",
      car_make: "Cherry edit",
      car_model: "DR5 edit"
      }}
    end
    
    it "can update an existing driver with valid information accurately, and redirect" do
      
      expect {
      patch driver_path(@driver.id), params: @updated_driver_hash}.wont_change "Driver.count"
      
      must_respond_with :redirect
      
      @updated_driver = Driver.find_by(id: @driver.id)
      expect(@updated_driver.name).must_equal @updated_driver_hash[:driver][:name]
      expect(@updated_driver.vin).must_equal @updated_driver_hash[:driver][:vin]
      expect(@updated_driver.car_make).must_equal @updated_driver_hash[:driver][:car_make]
      expect(@updated_driver.car_model).must_equal @updated_driver_hash[:driver][:car_model]
      
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      
      expect {
      patch driver_path(-1), params: @updated_driver_hash}.wont_change "Driver.count"
      
      if @driver = nil
        must_respond_with :not_found
      end
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      
      @updated_driver_hash = { driver: {
      name: "Kari edit",
      vin: "123456",
      car_make: "Cherry edit",
      car_model: nil}}
      
      expect {
      path driver_path(@driver.id), params: @updated_driver_hash}.wont_change "Driver.count"
      
      if @driver = nil  
        must_respond_with :redirect
      end
      
    end
  end
  
  describe "destroy" do
    before do
      @destroy_driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
    end
    
    it "destroys the driver instance in db when driver exists, then redirects" do
      
      expect{ 
      delete driver_path(@destroy_driver.id).must_change "Driver.count", -1}
      
      if @driver
        must_respond_with :redirect
        must_redirect_to drivers_path
      end
      
    end
    
    it "does not change the db when the driver does not exist, then responds with redirect" do
      
      expect{
      delete driver_path(-1).wont_change "Driver.count"}
      
      if @driver = nil
        must_respond_with :redirect
      end
    end
    
    describe "toggle_status" do
      it "can turn active status from true to false" do
        
        @driver = Driver.create(name: "Kari", vin: "123", active: true,
        car_make: "Cherry", car_model: "DR5")
        
        expect {
        patch toggle_status_driver_path(@driver)}.wont_change "Driver.count"
        
        find_driver = Driver.find_by(id: @driver.id)
        expect(find_driver.active).must_equal false
        
        must_respond_with :redirect
      end
      
      it "can turn active status from false to true" do
        
        @driver = Driver.create(name: "Kari", vin: "123", active: false,
        car_make: "Cherry", car_model: "DR5")
        
        expect {
        patch toggle_status_driver_path(@driver)}.wont_change "Driver.count"
        
        find_driver = Driver.find_by(id: @driver.id)
        expect(find_driver.active).must_equal true
        
        must_respond_with :redirect
      end
    end
  end
end

