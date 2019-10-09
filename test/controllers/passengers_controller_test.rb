require "test_helper"

describe PassengersController do
  
  let (:passenger) {
    Passenger.create name: "Jon Snow", phone_num: "123.345.6789"
  }
  describe "index" do
    # Your tests go here
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      get passenger_path(passenger.id)
      # Act/Assert
      must_respond_with :success
      
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      Passenger.destroy_all
      get passengers_path
      # Act/Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do
      # # Act
      get passenger_path(passenger.id)
      # # Assert
      must_respond_with :success
      
    end
    
    it "will redirect with an invalid passender id" do
      id = -1
      # # Act
      get passenger_path(id)
      # # Assert
      must_respond_with :redirect
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
      # Arrange
      # Set up the form data
      passenger_hash = {
        passenger: {
          name: "Tyrion Lannister",
          phone_num: "(908) 987-2345"
        },
      }
      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1
      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates passenger validations
      passenger_hash = {
        passenger: {
          name: "",
          phone_num: "234.456.2345"
        },
      }
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 0
      # Assert
      # Check that the controller renders successfully
      must_respond_with :success
      
    end
  end
  
  describe "edit" do
    # Your tests go here
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      get edit_passenger_path(passenger.id)
      
      must_respond_with :success
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      id = -1
      get edit_passenger_path(id)
      
      must_respond_with :redirect
      must_redirect_to passengers_path
      
    end
  end
  
  describe "update" do
    # Your tests go here
    before do
      Passenger.create(name: "Jon Snow", phone_num: "123.345.6789")
    end
    
    updated_passenger_hash = {
      passenger: {
        name: "Tyrion Lannister",
        phone_num: "(909) 234-2345"
      },
    }

    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data
      id = Passenger.first.id
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: updated_passenger_hash
      }.wont_change "Passenger.count"
      
      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      # Check that the controller redirected the user
      updated_passenger = Passenger.find_by(id: id)
      expect(updated_passenger.name).must_equal "Tyrion Lannister"
      expect(updated_passenger.phone_num).must_equal "(909) 234-2345"

      must_respond_with :redirect
    end
    
    it "will redirect to passengers page if given an invalid id" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      id = -1
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: updated_passenger_hash
      }.wont_change "Passenger.count"
      # Assert
      # Check that the controller redirect
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates passenger validations
      invalid_updated_passenger_hash = {
        passenger: {
          name: "",
          phone_num: "235.243.4365"
        },
      }
      id = Passenger.first.id
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(id), params: invalid_updated_passenger_hash
      }.must_differ "Passenger.count", 0
      # Assert
      # Check that the controller renders successfully
      must_respond_with :success
    end
  end
  
  describe "destroy" do
    # Your tests go here
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      Passenger.create(name: "Jon Snow", phone_num: "123.345.6789")
      existing_passenger_id = Passenger.find_by(name: "Jon Snow").id
      
      # Act-Assert
      # Ensure that there is a change of -1 in passenger.count
      expect {
        delete passenger_path( existing_passenger_id )
      }.must_differ "Passenger.count", -1

      # Assert
      # Check that the controller redirects
      must_redirect_to passengers_path

    end
    
    it "does not change the db when the passenger does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      Passenger.destroy_all
      invalid_passenger_id = 1
      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        delete passenger_path( invalid_passenger_id )
      }.must_differ "Passenger.count", 0
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_redirect_to passengers_path

    end
  end
end
