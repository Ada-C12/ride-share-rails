require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "Bob Ross", phone_num: "1234567891")
  }
  
  describe "index" do
    # Your tests go here
    
    it "gives back a successful response" do
      
      get passengers_path
      
      
      must_respond_with :success
    end
    
    
    
  end
  
  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      valid_passenger = passenger 
      
      
      # Ensure that there is a driver saved
      
      # Act
      get passenger_path(valid_passenger.id)
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      
      # Act
      get passenger_path(-1)
      
      
      # Assert
      must_respond_with :not_found 
      
    end
    
  end
  
  describe "new" do
    # Your tests go here
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success 
    end
  end
  
  describe "create" do
    # Your tests go here
    it "can create a new passenger with valid information accurately, and redirect" do
     
      passenger_hash = {
      passenger: {
          name: "John Doe",
          phone_num: "987654321",
        }
      }
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count',1

       must_redirect_to passenger_path(Passenger.find_by(name: "John Doe"))

      
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      passenger_hash = {
        passenger: {
            name: "",
            phone_num: "",
          }
        }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count',0

      
      # Assert
      # Check that the controller redirects
      assert_template :new
      
    end
  end
  
  describe "edit" do
    # Your tests go here
  end
  
  describe "update" do
    # Your tests go here
  end
  
  describe "destroy" do
    # Your tests go here
  end
end
