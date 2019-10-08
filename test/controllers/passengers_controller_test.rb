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

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_passenger_path(-20)
      
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
  
  describe "update" do
    it "" do
      # Your tests go here
    end
  end
  
  describe "destroy" do
    it "" do
      # Your tests go here
    end
  end
end
