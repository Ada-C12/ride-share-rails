require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      Driver.create(name: "Jane Doe", vin: "12345678")
      
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
      expect(Driver.count).must_equal 1
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
      expect(Driver.count).must_equal 0
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      
      # Act
      get driver_path(valid_driver.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      # Act
      
      get driver_path("-1")
      
      # Assert
      must_respond_with :not_found
      
    end
  end
  
  describe "new" do
    it "responds with success" do
      driver_hash = {driver: {name: "Sally Sue", vin: "1234556"}}
      
      get new_driver_path(driver_hash)
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      driver_hash = {driver: {name: "Sally Sue", vin: "1234556"}}
      
      expect {post drivers_path, params: driver_hash}.must_differ 'Driver.count', 1
      
      new_driver_id = Driver.find_by(name:"Sally Sue").id
      must_redirect_to driver_path(new_driver_id)
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      invalid_driver_hash = {driver: {vin: "1234556"}}
      invalid_driver_hash_2 = {driver: {name: "Bob Smith"}}
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {post drivers_path, params: invalid_driver_hash}.must_differ 'Driver.count', 0
      
      # Assert
      # Check that the controller redirects
      must_redirect_to new_driver_path
      
      expect {post drivers_path, params: invalid_driver_hash_2}.must_differ 'Driver.count', 0
      must_redirect_to new_driver_path
      
    end
  end
  
  describe "edit" do
    let(:current_driver) {Driver.create(name: "Jane Doe", vin: "12345678")}

    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      get edit_driver_path(current_driver.id)
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      new_driver = current_driver
      get edit_driver_path(-1)

      must_respond_with :redirect
    end
  end
  
  describe "update" do
    let(:updates) {{driver: {name: "Another Name", vin:'789987324'}}}
    let(:current_driver) {Driver.create(name: "Jane Doe", vin: "12345678")}
    let(:invalid_updates_1) {{driver: {name: "Another Name"}}}
    let(:invalid_updates_2) {{driver: {vin: "789987324"}}}

    it "can update an existing driver with valid information accurately, and redirect" do
      patch driver_path(current_driver.id), params: updates
      
      updated_driver = Driver.find_by(id: current_driver.id)
      expect(updated_driver.name).must_equal updates[:driver][:name]
      expect(updated_driver.vin).must_equal updates[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(updated_driver.id)
    end
    
    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      patch driver_path(-1), params: updates
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      updated_driver = Driver.find_by(id: current_driver.id)
      expect(updated_driver.name).wont_equal updates[:driver][:name]
      expect(updated_driver.vin).wont_equal updates[:driver][:vin]
      
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end
    
    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      # Assert
      # Check that the controller redirects
      updated_driver = Driver.find_by(id: current_driver.id)
      expect {patch driver_path(updated_driver.id), params: invalid_updates_1}.must_differ 'Driver.count', 0
      must_respond_with :redirect

      expect {patch driver_path(updated_driver.id), params: invalid_updates_2}.must_differ 'Driver.count', 0
      must_respond_with :redirect
      
    end
  end
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      
      # Assert
      # Check that the controller redirects
      
    end
    
    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      
    end
  end
end
