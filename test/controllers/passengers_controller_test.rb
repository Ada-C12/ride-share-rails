require "test_helper"

describe PassengersController do
  let (:passenger) { Passenger.create(name: "Barney Rubble", phone_num: "123-456-7890") }
  
  describe "index" do
    it "responds with success when there is at least one passenger saved" do      
      # Arrange
      passenger.save
      
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success   
    end
    
    it "responds with success when there are no passengers saved" do
      # Act
      get passengers_path
      
      # Assert
      expect(Passenger.count).must_equal 0
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      passenger.save
      
      # Act
      get passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect for invalid passenger id" do
      # Arrange
      invalid_id = -1
      
      # Act
      get passenger_path(invalid_id)
      
      # Assert
      must_redirect_to passengers_path
    end
  end
  
  describe "new" do
    it "responds with success" do
      # Act
      get new_passenger_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = { passenger: { name: "Fred Flintstone", phone_num: "123" } }
      
      # Act-Assert
      expect { post passengers_path, params: passenger_hash }.must_change "Passenger.count", 1
      
      # Assert
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      must_respond_with :redirect
    end
    
    it "does not create a passenger if the form data violates Passenger validations" do
      # Arrange
      passenger_hash = { passenger: { name: "Dino" } }
      
      # Act-Assert
      expect { post passengers_path, params: passenger_hash }.wont_change "Passenger.count"
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      passenger.save
      
      # Act
      get edit_passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
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
      passenger.save
      changes = { passenger: { name: "Wilma Flintstone", phone_num: "456"} }
      
      # Act-Assert
      expect { patch passenger_path(passenger.id), params: changes }.wont_change "Passenger.count"  
      
      # Assert
      updated_passenger = Passenger.find_by(id: passenger.id)
      
      expect(updated_passenger.name).must_equal changes[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal changes[:passenger][:phone_num]
      
      must_respond_with :redirect
    end
    
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      passenger_hash = { passenger: { name: "Wilma Flintstone", phone_num: "456"}}
      
      # Act-Assert
      expect { patch passenger_path(-1), params: passenger_hash }.wont_change "Passenger.count"
      
      # Assert
      must_redirect_to passengers_path
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Arrange
      passenger.save
      passenger_hash = { passenger: { name: "Dino" } }
      
      # Act-Assert
      expect { patch passenger_path(passenger.id), params: passenger_hash }.wont_change "Passenger.count"
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      passenger.save
      
      # Act-Assert
      expect{ delete passenger_path(passenger.id) }.must_differ "Passenger.count", -1
      
      # Assert
      must_respond_with :redirect
    end
    
    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      invalid_id = -1
      
      # Act-Assert
      expect{ delete passenger_path(invalid_id)}.wont_change "Passenger.count"
      
      # Assert
      must_respond_with :redirect
    end
  end
end
