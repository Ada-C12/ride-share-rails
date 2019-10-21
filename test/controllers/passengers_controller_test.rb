require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Test Passenger", phone_num: "360-456-9875"
  }
  describe "index" do
    
    it "can get the index path" do
      get passengers_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    
    it "can get a valid passenger" do
      get passenger_path(passenger.id)
      
      must_respond_with :success
    end
    
    it "will redirect for an invalid id" do
      
      get passenger_path(-1)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find passenger"
    end
  end
  
  describe "new" do
    
    it "can get a new task path" do
      
      get new_passenger_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "test 1",
          phone_num: "123456789"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
    
    
  end
  
  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to find a nonexistant passenger" do
      get edit_passenger_path(-13)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find passenger"
    end
  end
  
  describe "update" do
    
    it "can update an existing passenger" do
      old_passenger = Passenger.find(passenger.id)
      
      passenger_hash = {
        passenger: {
          name: "test 2",
          phone_num: "123456789"
        }
      }
      expect {
        patch passenger_path(passenger.id), params: passenger_hash
      }.wont_change "Passenger.count"
      
      expect(Passenger.find(old_passenger.id).name).wont_equal old_passenger.name
      
    end
    
    
  end
  
  describe "destroy" do
    
    it "can destroy an existing passenger" do
      old_passenger =Passenger.find(passenger.id)
      
      expect {delete passenger_path(passenger.id)}.must_change "Passenger.count", -1
    end
    
    it "will respond with a redirect when given a passenger that does not exist" do
      delete passenger_path(-12)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find passenger"
    end
  end
end
