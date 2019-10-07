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
