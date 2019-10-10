require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      get drivers_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it 'responds with a success when id given exists' do
      valid_driver = Driver.create(name: "Ada Lovelace", vin: 5035699987, make: "toyota", model: "prius", active: true)
      get driver_path(valid_driver.id)
      must_respond_with :success
    end
    
    
    it "responds with 404 with an invalid driver id" do
      get driver_path("5000")
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
          name: "ada lovelace",
          vin: "2342334234242",
          make: "toyota",
          model: "prius"
        }
      }
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1
      must_redirect_to drivers_path
    end
  end
  
  xit "does not create a driver If the form data violates Driver validations, and responds with a redirect" do
    # Note: This will not pass Until ActiveRecord Validations lesson
    # Arrange
    # Set up the form data so that it violates Driver validations
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Check that the controller redirects
    
  end
  
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      
      # Act
      get edit_driver_path(driver.id)
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      driver_id = -1
      # Act
      get edit_driver_path(driver.id)
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    before do
      @valid_driver = Driver.create(name: "Ada Lovelace", vin: "234834978", make: "Toyota", model: "Prius")
    end
    it "updates an existing driver successfully and redirects to home" do
      existing_driver = Driver.first
      updated_driver_hash = {
        driver: {
          name: "Bill Gates",
          vin: "234834978",
          make: "Toyota",
          model: "Prius"
        }
      }
      expect {
        patch driver_path(existing_driver.id), params: updated_driver_hash
      }.wont_change 'Driver.count'
      # Assert
      expect( Driver.find_by(id: existing_driver.id).name ).must_equal "Bill Gates"
      expect( Driver.find_by(id: existing_driver.id).vin ).must_equal "234834978"
      expect( Driver.find_by(id: existing_driver.id).make ).must_equal "Toyota"
      expect( Driver.find_by(id: existing_driver.id).model ).must_equal "Prius"
    end
  end
  
  it "does not update any driver if given an invalid id, and responds with a 404" do
    driver_hash = {
      driver: {
        name: "ada lovelace",
        vin: "2342334234242",
        make: "toyota",
        model: "prius"
      }
    }
    expect {
      post drivers_path, params: driver_hash
    }.must_differ 'Driver.count', -1
    must_redirect_to drivers_path
  end
  
  xit "does not create a driver If the form data violates Driver validations, and responds with a redirect" do
    # Note: This will not pass Until ActiveRecord Validations lesson
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
    new_driver = Driver.create(name: "Bill Gates", vin: "234834978", make: "Toyota", model: "Prius")
    # Act-Assert
    # Ensure that there is a change of -1 in Driver.count
    expect { delete_driver_path(new_driver.id) }.must_change "Driver Count", -1
    # Assert
    # Check that the controller redirects
    must_respond_with :redirect
    must_redirect_to drivers_path
  end
  
  xit "does not change the db when the driver does not exist, then responds with " do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Check that the controller responds or redirects with whatever your group decides
    
  end
end

