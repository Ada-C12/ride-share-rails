require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "test passenger", phone_num: "111-111-1111"
  }
  
  describe "index" do
    it "can get the index path" do
      get passengers_path
      
      must_respond_with :success
    end
    
    it "can get the root path" do
      get root_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)
      
      must_respond_with :success
    end
    
    it "will redirect for an invalid passenger" do
      get passenger_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "created passenger",
          phone_num: "111-111-1111"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end
  
  describe "edit" do
    it "can get the edit page for an existing passenger" do
      
      get edit_passenger_path(passenger.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(646594)
      
      must_respond_with :redirect
      must_redirect_to '/passengers'
    end
  end
  
  describe "update" do
    existing_passenger = Passenger.create(name: "test passenger", phone_num: "111-111-1111")
    update_info = {
      passenger: {
        name: "test passenger (edited)",
        phone_num: "222-222-2222"
      }
    }
    
    it "can update an existing passenger" do
      patch passenger_path(existing_passenger.id), params: update_info
      
      updated_passenger = Passenger.find_by(id: existing_passenger.id)
      expect(updated_passenger.name).must_equal update_info[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal update_info[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(updated_passenger.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch passenger_path(54645656456), params: update_info
      
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
  
  describe "destroy" do
    passenger = Passenger.create(name: "sample passenger", phone_num: "121-121-1122")
    
    it "deletes an existing book successfully" do
      expect {
        delete passenger_path( passenger.id )
      }.must_differ "Passenger.count", -1
      
      must_redirect_to passengers_path
    end
    
    it "redirects if book is not available to delete" do
      expect {
        delete passenger_path( 500 )
      }.must_differ "Passenger.count", 0
      
      must_redirect_to passengers_path
    end
    
    it "redirects if book has already been deleted" do
      Passenger.destroy_all
      expect {
        delete passenger_path( passenger.id )
      }.must_differ "Passenger.count", 0
      
      must_redirect_to passengers_path
    end
  end
end