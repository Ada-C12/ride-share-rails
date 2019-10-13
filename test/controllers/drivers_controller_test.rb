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
      expect (Driver.count).must_equal 0
      
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
      expect (Driver.count).must_equal 0
      
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
      expect (created_driver.name).must_equal new_driver[:driver][:name]
      expect (created_driver.vin).must_equal new_driver[:driver][:vin]
      
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
    # Arrange
    # Ensure there is an existing driver saved
    
    # Act
    
    # Assert
    
  end
  
  it "responds with redirect when getting the edit page for a non-existing driver" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    
    # Act
    
    # Assert
    
  end
end

describe "update" do
  it "can update an existing driver with valid information accurately, and redirect" do
    # Arrange
    # Ensure there is an existing driver saved
    # Assign the existing driver's id to a local variable
    # Set up the form data
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
    # Check that the controller redirected the user
    
  end
  
  it "does not update any driver if given an invalid id, and responds with a 404" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    # Set up the form data
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Check that the controller gave back a 404
    
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
