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
      expect(Passenger.count).must_equal 0
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      test_passenger = passenger
      
      # Act
      get passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger
      invalid_id = -1
      
      # Act
      get passenger_path(invalid_id)
      
      # Assert
      must_redirect_to passengers_path
    end
  end
  
  describe "new" do
    it "responds with success" do
      get new_passenger_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      passenger_hash = { passenger: { name: "Fred Flintstone", phone_num: "123" } }
      
      # Act-Assert
      # Ensure that there is a change of 1 in Passenger.count
      expect { post passengers_path, params: passenger_hash }.must_change "Passenger.count", 1
      
      # Assert
      # Find the newly created Passenger, and check that all its attributes match what was given in the form data
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      # Check that the controller redirected the user
      must_respond_with :redirect
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Arrange
      # Set up the form data so that it violates Passenger validations
      passenger_hash = { passenger: { name: "Dino" } }
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect { post passengers_path, params: passenger_hash }.wont_change "Passenger.count"
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      test_passenger = passenger
      
      # Act
      get edit_passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      invalid_id = -1
      
      # Act
      get edit_passenger_path(invalid_id)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      test_passenger = passenger
      changes = { passenger: { name: "Wilma Flintstone", phone_num: "456"} }
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect { patch passenger_path(test_passenger.id), params: changes }.wont_change "Passenger.count"  
      
      patch passenger_path(test_passenger.id), params: changes
      
      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      updated_passenger = Passenger.find_by(id: test_passenger.id)
      
      expect(updated_passenger.name).must_equal changes[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal changes[:passenger][:phone_num]
      
      # Check that the controller redirected the user
      must_respond_with :redirect
    end
    
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      passenger_hash = { passenger: { name: "Wilma Flintstone", phone_num: "456"}}
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect { patch passenger_path(-1), params: passenger_hash }.wont_change "Passenger.count"
      
      patch passenger_path(-1), params: passenger_hash
      
      # Assert
      # Check that the controller gave back a 404
      must_redirect_to passengers_path
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      passenger_id = passenger.id
      
      # Set up the form data so that it violates Passenger validations
      passenger_hash = { passenger: { name: "Dino" } }
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect { patch passenger_path(passenger_id), params: passenger_hash }.wont_change "Passenger.count"
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
  end
  
  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      test_passenger = passenger
      
      # Act-Assert
      # Ensure that there is a change of -1 in Passenger.count
      expect{ delete passenger_path(test_passenger.id) }.must_differ "Passenger.count", -1
      
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end
    
    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      invalid_id = -1
      
      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect{ delete passenger_path(invalid_id)}.wont_change "Passenger.count"
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
    end
  end
end
