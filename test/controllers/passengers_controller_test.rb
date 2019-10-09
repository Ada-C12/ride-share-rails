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
    it "responds with success" do
      passenger_hash = {passenger: {name: "Sally Sue", phone_num: "1234556"}}
      
      get new_passenger_path(passenger_hash)
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_hash = {passenger: {name: "Sally Sue", phone_num: "12345567"}}
      
      expect {
        post passengers_path, params: passenger_hash}.must_differ 'Passenger.count', 1
        
        new_passenger_id = Passenger.find_by(name:"Sally Sue").id
        must_redirect_to passenger_path(new_passenger_id)
      end
      
      it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
        # Note: This will not pass until ActiveRecord Validations lesson
        # Arrange
        # Set up the form data so that it violates Passenger validations
        invalid_passenger_hash = {passenger: {phone_num: "12345567"}}
        invalid_passenger_hash_2 = {passenger: {name: "Sally Sue"}}
        
        # Act-Assert
        # Ensure that there is no change in passenger.count
        expect {post passengers_path, params: invalid_passenger_hash}.must_differ 'Passenger.count', 0
        
        # Assert
        # Check that the controller redirects
        must_redirect_to new_passenger_path
        
        expect {post passengers_path, params: invalid_passenger_hash_2}.must_differ 'Passenger.count', 0
        must_redirect_to new_passenger_path
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
  