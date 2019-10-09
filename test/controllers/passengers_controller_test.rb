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
