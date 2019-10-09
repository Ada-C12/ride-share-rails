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
      let(:current_passenger) {Passenger.create(name: "Jane Doe", phone_num: "1234567")}

      it "responds with success when getting the edit page for an existing, valid passenger" do
        # Arrange
        # Ensure there is an existing passenger saved
        get edit_passenger_path(current_passenger.id)
        must_respond_with :success
      end
      
      it "responds with redirect when getting the edit page for a non-existing passenger" do
        new_passenger = current_passenger
        get edit_passenger_path(-1)
  
        must_respond_with :redirect
      end
    end
    
    describe "update" do
      let(:updates) {{passenger: {name: "Another Name", phone_num:'789987324'}}}
      let(:current_passenger) {Passenger.create(name: "Jane Doe", phone_num: "12345678")}
      let(:invalid_updates_1) {{passenger: {name: "Another Name"}}}
      let(:invalid_updates_2) {{passenger: {phone_num: "789987324"}}}

    it "can update an existing passenger with valid information accurately, and redirect" do
      patch passenger_path(current_passenger.id), params: updates
      
      updated_passenger = Passenger.find_by(id: current_passenger.id)
      expect(updated_passenger.name).must_equal updates[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal updates[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(updated_passenger.id)
    end
    
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      patch passenger_path(-1), params: updates
      
      # Act-Assert
      # Ensure that there is no change in passenger.count
      updated_passenger = Passenger.find_by(id: current_passenger.id)
      expect(updated_passenger.name).wont_equal updates[:passenger][:name]
      expect(updated_passenger.phone_num).wont_equal updates[:passenger][:phone_num]
      
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates passenger validations
      
      # Act-Assert
      # Ensure that there is no change in passenger.count
      # Assert
      # Check that the controller redirects
      updated_passenger = Passenger.find_by(id: current_passenger.id)
      expect {patch passenger_path(updated_passenger.id), params: invalid_updates_1}.must_differ 'Passenger.count', 0
      must_respond_with :redirect

      expect {patch passenger_path(updated_passenger.id), params: invalid_updates_2}.must_differ 'Passenger.count', 0
      must_respond_with :redirect
    end
  end
    
  describe "destroy" do
    # Your tests go here
  end
end
  