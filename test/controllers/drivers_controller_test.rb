require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
      driver = Driver.find_by(name: "Kari")
      # Ensure that there is at least one Driver saved
      
      
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
      
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      
      # Act
      get drivers_path
      
      # Assert
      must_respond_with :success
      
    end
  end
  
  describe "show" do
    before do
      @new_driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
    end
    
    it "responds with success when showing an existing valid driver" do
      # Arrange
      driver = Driver.find_by(name: "Kari")
      # Ensure that there is a driver saved ??????
      
      # Act
      get driver_path(driver.id)
      
      # Assert
      must_respond_with :success
      
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      
      # Act
      get driver_path(-1)
      
      # Assert
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
      driver_hash = { driver: {
      name: "Jin",
      vin: "1234",
      car_make: "Honda",
      car_model: "Civic"}
    }
    
    # Act-Assert
    # Ensure that there is a change of 1 in Driver.count
    expect {post drivers_path, params: driver_hash}.must_change "Driver.count", 1
    
    # Assert
    # Find the newly created Driver, and check that all its attributes match what was given in the form data
    
    new_driver = Driver.find_by(name: driver_hash[:driver][:name])
    expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
    expect(new_driver.car_make).must_equal driver_hash[:driver][:car_make]
    expect(new_driver.car_model).must_equal driver_hash[:driver][:car_model]
    # Check that the controller redirected the user
    must_respond_with :redirect
    must_redirect_to driver_path(new_driver.id)
    
  end
  
  it "does not create a driver if the form data violates  Driver validations, and responds with a redirect" do
    # Note: This will not pass until ActiveRecord Validations lesson
    # Arrange
    driver_hash = { driver: {
    name: nil,
    vin: nil,
    car_make: nil}}
    # Set up the form data so that it violates Driver validations
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    expect {
    post drivers_path, params: driver_hash}.wont_change "Driver.count"
    
    must_respond_with :success
    
    # Assert
    # Check that the controller redirects
    
  end
end

describe "edit" do
  before do
    @edit_driver = Driver.create(name: "Kari", vin: "123", active: false, car_make: "Cherry", car_model: "DR5")
  end
  it "responds with success when getting the edit page for an existing, valid driver" do
    # Arrange
    
    # Ensure there is an existing driver saved
    get edit_driver_path(@edit_driver.id)
    # Act
    
    # Assert
    must_respond_with :success
    
  end
  
  it "responds with redirect when getting the edit page for a non-existing driver" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    get edit_driver_path(-1)
    
    # Act
    
    # Assert
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
    # Arrange
    # Ensure there is an existing driver saved
    # Assign the existing driver's id to a local variable
    # Set up the form data
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    expect {
    patch driver_path(@driver.id), params: @updated_driver_hash}.wont_change "Driver.count"
    
    must_respond_with :redirect
    # Assert
    # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
    # Check that the controller redirected the user
    
    @updated_driver = Driver.find_by(id: @driver.id)
    expect(@updated_driver.name).must_equal @updated_driver_hash[:driver][:name]
    expect(@updated_driver.vin).must_equal @updated_driver_hash[:driver][:vin]
    expect(@updated_driver.car_make).must_equal @updated_driver_hash[:driver][:car_make]
    expect(@updated_driver.car_model).must_equal @updated_driver_hash[:driver][:car_model]
    
  end
  
  it "does not update any driver if given an invalid id, and responds with a 404" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    # Set up the form data
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    expect {
    path driver_path(-1), params: @updated_driver_hash}.wont_change "Driver.count"
    
    # Assert
    # Check that the controller gave back a 404
    if @driver = nil
      must_respond_with :not_found
    end
  end
  
  it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
    # Note: This will not pass until ActiveRecord Validations lesson
    # Arrange
    @updated_driver_hash = { driver: {
    name: "Kari edit",
    vin: "123456",
    car_make: "Cherry edit",
    car_model: nil}}
    # Ensure there is an existing driver saved
    # Assign the existing driver's id to a local variable
    # Set up the form data so that it violates Driver validations
    
    # Act-Assert
    expect {
    path driver_path(@driver.id), params: @updated_driver_hash}.wont_change "Driver.count"
    # Ensure that there is no change in Driver.count
    
    # Assert
    
    # Check that the controller redirects
    
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
    # Arrange
    # Ensure there is an existing driver saved
    expect{ 
    delete driver_path(@destroy_driver.id).must_change "Driver.count", -1}
    # Act-Assert
    # Ensure that there is a change of -1 in Driver.count
    
    # Assert
    # Check that the controller redirects
    if @driver
      must_respond_with :redirect
      must_redirect_to drivers_path
    end
    
  end
  
  it "does not change the db when the driver does not exist, then responds with redirect" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    expect{
    delete driver_path(-1).wont_change "Driver.count"
  }
  # Act-Assert
  # Ensure that there is no change in Driver.count
  
  # Assert
  # Check that the controller responds or redirects with whatever your group decides
  
  if @driver = nil
    must_respond_with :redirect
  end
  
  
end
end
end
