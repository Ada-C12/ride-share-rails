require "test_helper"
require 'pry'

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      get drivers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers saved" do
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      valid_driver = Driver.create(name: "Valid Driver", vin: "56")
      get driver_path(valid_driver.id)
      must_respond_with :success
      
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      get driver_path(-1)
      # Act
      # Assert
      must_respond_with :missing 
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
      driver_hash= {
        driver:{
          name: "Hyuo",
          vin: "43c56"
        }
      }
      drivers_count = Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 1
      
      expect(Driver.count).must_equal(drivers_count + 1 )
      
      must_respond_with :redirect
      must_redirect_to  drivers_path
    end
    
    it "cannot create a new driver with invalid name" do
      invalid_driver_hash= {
        driver:{
          name: nil,
          vin: "43c56"
        }
      }
      
      expect {
        post drivers_path, params: invalid_driver_hash
      }.must_differ "Driver.count", 0
    end
    
    it "cannot create a new driver with invalid name" do
      invalid_driver_hash= {
        driver:{
          name: "george",
          vin: nil
        }
      }
      
      expect {
        post drivers_path, params: invalid_driver_hash
      }.must_differ "Driver.count", 0
    end
    
  end
  
  describe "edit" do
    before do
      @new_driver = Driver.create(name: "Hyuo", vin: "1234567890h")
    end
    
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(@new_driver.id)
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end
  
  describe "update" do
    before do
      @new_driver = Driver.create(name: "Hyuo", vin: "8888888")
    end
    
    
    it "updates an existing driver successfully" do
      existing_driver = Driver.first
      
      updated_driver_form_data = {
        driver: {
          name: "yoo",
          vin: "657g56"
        }
      }
      expect {
        patch driver_path(existing_driver.id), params: updated_driver_form_data
      }.wont_change 'Driver.count'
      
      # Assert
      expect( Driver.find_by(id: existing_driver.id).name).must_equal "yoo"
      expect( Driver.find_by(id: existing_driver.id).vin).must_equal "gft6rt"
    end
    
    it "will redirect to the root page if given an invalid id" do
      
      updated_driver_form_data = {
        driver: {
          name: "yoo",
          vin: "657g56"
        }
      }
      
      expect {
        patch driver_path(6574689), params: updated_driver_form_data
      }.wont_change 'Driver.count', -1
      
      must_respond_with :redirect
      must_redirect_to root_path
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
