require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  before do
    deleted_driver = Driver.new(id: 0, name: "previously deleted", vin: "00000000000000000")
    deleted_driver.save
  end

  describe "index" do
    it "responds with success when there are many drivers saved" do
      test_driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      
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
      @test_driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
    end
    
    it "responds with success when showing an existing valid driver" do
      get driver_path(@test_driver.id) 
      
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
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "vince",
          vin: "fjfjfj34jfis84hgj"
        }
      }
      
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect { post drivers_path, params: driver_hash }
      .must_change "Driver.count", 1
      
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_driver = Driver.find_by(name: "vince")
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
        driver: {
          name: "vince",
        }
      }
      expect { post drivers_path, params: driver_hash }
      .wont_change "Driver.count"
      
      must_respond_with :success
      # response of "success" expected because redirect should be successful 
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      
      # Act
      get edit_driver_path(driver.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = -1
      assert_nil Driver.find_by(id: id)
      # Act
      get edit_driver_path(id)
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
      driver = Driver.create(name: "Popeye Sailor", vin: -1)
      
      id = driver.id
      params = { driver: { vin: -1 } }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{ patch driver_path(id), params: params }.wont_change "Driver.count"
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      expect(Driver.find(id).vin.to_i).must_equal params.dig(:driver, :vin)
      must_respond_with :redirect
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      id = -1
      assert_nil Driver.find_by(id: id)
      params = { driver: { vin: -1 } }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{ patch driver_path(id), params: params }.wont_change "Driver.count"
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      
      driver = Driver.create(name: "Popeye Sailor", vin: "JD74HGJK245DLJR93")
      
      id = driver.id
      params = { driver: { vin: "" } }
      
      expect{ patch driver_path(id), params: params }.wont_change "Driver.count"
      # must_respond_with :render
      
    end
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      delete driver_path(Driver.first.id)
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      
    end
    
    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = -1
      assert_nil Driver.find_by(id: id)
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{ delete driver_path(id) }.wont_change "Driver.count" 
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
