require "test_helper"

describe PassengersController do
  describe "index" do  
    it "responds with success when there are many passengers saved" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      get passengers_path
      
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      expect(Passenger.count).must_equal 0
      get passengers_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      test_passenger = Passenger.create(name: "test person", phone_num: "1234567")
      get passenger_path(test_passenger.id)
      
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(99999)
      
      must_respond_with :not_found
    end
  end
  
  describe "new" do
    # Your tests go here
  end
  
  describe "create" do
    # Your tests go here
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
