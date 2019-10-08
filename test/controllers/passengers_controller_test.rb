require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      Passenger.create(name: "Jane Doe", phone_num: "12345678")
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success
      expect(Passenger.count).must_equal 1
    end
    
    it "responds with success when there are no passengers saved" do
      # Arrange
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success
      expect(Passenger.count).must_equal 0
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      valid_passenger = Passenger.create(name: "Jane Doe", phone_num: "12345678")
      
      # Act
      get passenger_path(valid_passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger
      valid_passenger = Passenger.create(name: "Jane Doe", phone_num: "12345678")
      # Act
      
      get passenger_path("-1")
      
      # Assert
      must_respond_with :not_found
      
    end
  end
  
  describe "new" do
    # Your tests go here
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
