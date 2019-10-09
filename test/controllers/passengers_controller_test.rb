require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") 
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do      
      test_passenger = passenger
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success   
    end
    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a driver saved
      test_passenger = passenger
      
      # Act
      get passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      
      # Act
      get passenger_path(-1)
      
      # Assert
      must_respond_with :not_found
    end
  end
  
  describe "new" do
    it "responds with success" do
      get new_passenger_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    # Your tests go here
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
