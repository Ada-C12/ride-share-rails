require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "sample number")
  }
  
  describe "index" do
    it "responds with success when there is at least one Passenger saved" do
      Passenger.create(name: "test passenger", phone_num: "test number")
      
      get passengers_path
      
      must_respond_with :success
      expect(Passenger.count).must_be :>, 0
    end
    
    it "responds with success when there are no passengers saved" do
      get passengers_path
      
      must_respond_with :success
      expect(Passenger.count).must_equal 0
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      get passenger_path(passenger.id)
      
      must_respond_with :success
      expect(Passenger.count).must_be :>, 0
    end
    
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-20)
      
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
          name: "new passenger",
          phone_num: "new phone number"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a render of new passenger page" do
      new_passenger = Passenger.create(name: "", phone_num: "")
      
      expect(Passenger.count).must_equal 0
      
      expect(new_passenger.valid?).must_equal false
      
      
      # # Assert
      # # Check that the controller redirects
      # must_redirect_with :render
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(passenger.id)
      
      must_respond_with :success
      expect(Passenger.count).must_be :>, 0
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-20)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      passenger_hash = { 
        passenger: { 
          name: "Updated name",
          phone_num: "Updated number"
        }
      }
      
      passenger_to_update = passenger
      
      expect {
        patch passenger_path(passenger_to_update.id), params: passenger_hash
      }.must_differ "Passenger.count", 0
      
      updated_passenger = Passenger.find_by(id: passenger.id)
      
      expect(updated_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      passenger_hash = { 
        passenger: { 
          name: "Updated name",
          phone_num: "Updated number"
        }
      }
      
      expect {
        patch passenger_path(-20), params: passenger_hash
      }.must_differ "Passenger.count", 0
      
      must_respond_with :not_found
    end
    
    it "does not update a passenger if the form data violates Passenger validations, and responds with a render of current page" do
      passenger_hash = { 
        passenger: { 
          name: "",
          phone_num: "Updated number"
        }
      }

      passenger_to_update = passenger

      expect {
        patch passenger_path(passenger_to_update.id), params: passenger_hash
      }.must_differ "Passenger.count", 0

      validity = passenger_to_update.update(name: "", phone_num: "Updated number")

      expect(validity).must_equal false
      
      # # Assert
      # # Check that the controller redirects
      # must_redirect_with :render
      # Note: This will not pass until ActiveRecord Validations lesson

      
    end
  end
  
  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      id_to_delete = passenger.id
      
      expect {
        delete passenger_path(id_to_delete)
      }.must_differ "Passenger.count", -1

      removed_passenger = Passenger.find_by(id: passenger.id)
      removed_passenger.must_be_nil
      
      must_redirect_to passengers_path
      
    end
    
    it "does not change the db when the passenger does not exist, then responds with " do
      nonexistent_id = -20
      
      expect {
        delete passenger_path(nonexistent_id)
      }.must_differ "Passenger.count", 0
      
      must_redirect_to passengers_path
    end

    it "will redirect to passenger index page if passenger was already deleted" do
      id_to_delete = passenger.id
      Passenger.destroy_all
      
      expect {
        delete passenger_path(id_to_delete)
      }.must_differ "Passenger.count", 0
      
      must_redirect_to passengers_path
    end
  end
end
