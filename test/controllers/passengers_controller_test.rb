require "test_helper"

describe PassengersController do
  
  describe "index" do
    
    it "responds with success when there are many passengers saved" do
      Passenger.create name: "new name", phone_num: "new number"
      
      get passengers_path
      
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      get passengers_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    let (:passenger) {
      Passenger.create(name: "new name", phone_num: "new number")
    }
    it "responds with success when showing an existing valid passenger" do
      
      get passenger_path(passenger.id)
      
      must_respond_with :success
    end
    it "responds with 404 with an invalid passenger id" do
      
      get passenger_path(-1)
      
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
    it "can create a new passenger with valid information accurately, and redirect" do
      
      passenger_hash = {
        passenger: {
          name: "REALLY new name",
          phone_num: "new number"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      passenger_hash = {
        passenger: {
          name: nil,
          phone_num: "new number"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 0
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(1)

      must_respond_with :found
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(500)

      must_respond_with :redirect
    end
    
  end
  
  describe "update" do
    before do
      Passenger.create(name: "Tom", phone_num: "12345")
    end

    let (:new_passenger_hash) {
      {
        passenger: {
          name: "Tom",
          phone_num: "543221"
        }
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
    
      id = Passenger.first.id
      expect {
        patch passenger_path(id), params: new_passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :redirect

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger_hash[:passenger][:phone_num]
    end
    
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      
      # Act-Assert
      # Ensure that there is no change in passenger.count
      
      # Assert
      # Check that the controller gave back a 404
      
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
      
    end
  end
  
  describe "destroy" do
    
  end
end


