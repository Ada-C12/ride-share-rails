require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. 
  # For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:driver_fred) { Driver.create(name: "Fred Flintstone", vin: "123", car_make: "dinosaur", car_model: "t-rex", available: true) }
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      test_driver = driver_fred
      
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success      
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      expect(Driver.count).must_equal 0
      
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
      test_driver = driver_fred
      
      # Act
      get driver_path(driver_fred.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "redirects to drivers path if given invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_id = -1
      
      # Act
      get driver_path(invalid_id)
      
      # Assert
      must_redirect_to drivers_path
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
      driver_hash = { driver: { name: "Barney Rubble", vin: "456", car_make: "bird", car_model: "robin", available: false } }
      
      # Act-Assert
      expect { post drivers_path, params: driver_hash }.must_change "Driver.count", 1
      
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.car_make).must_equal driver_hash[:driver][:car_make]
      expect(new_driver.car_model).must_equal driver_hash[:driver][:car_model]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]
      
      # Check that the controller redirected the user
      must_respond_with :redirect
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = { driver: { name: "Dino" } }
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { post drivers_path, params: driver_hash }.wont_change "Driver.count"
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end  
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      test_driver = driver_fred
      
      # Act
      get edit_driver_path(driver_fred.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1
      
      # Act
      get edit_driver_path(invalid_id)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      original_driver = driver_fred
      changes = { driver: { name: "Wilma Flintstone", vin: "456", car_make: "bird", car_model: "robin", available: false } }
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { patch driver_path(original_driver.id), params: changes }.wont_change "Driver.count"
      
      patch driver_path(original_driver.id), params: changes
      
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      updated_driver = Driver.find_by(id: original_driver.id)
      
      expect(updated_driver.name).must_equal changes[:driver][:name]
      expect(updated_driver.vin).must_equal changes[:driver][:vin]
      expect(updated_driver.car_make).must_equal changes[:driver][:car_make]
      expect(updated_driver.car_model).must_equal changes[:driver][:car_model]
      
      # Check that the controller redirected the user
      must_respond_with :redirect
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      driver_hash = { driver: { name: "Wilma Flintstone", vin: "456", car_make: "bird", car_model: "robin", available: false }}
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { patch driver_path(-1), params: driver_hash }.wont_change "Driver.count"
      
      patch driver_path(-1), params: driver_hash
      
      # Assert
      # Check that the controller gave back a 404
      must_redirect_to drivers_path
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Arrange
      driver_id = driver_fred.id
      
      # Set up the form data so that it violates Driver validations
      driver_hash = { driver: { name: "Dino" } }
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { patch driver_path(driver_id), params: driver_hash }.wont_change "Driver.count"
      
      patch driver_path(driver_id), params: driver_hash
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      test_driver = driver_fred
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect{ delete driver_path(test_driver.id)}.must_differ "Driver.count", -1
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      
    end
    
    it "does not change the db when the driver does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect{ delete driver_path(invalid_id)}.wont_change "Driver.count"
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
