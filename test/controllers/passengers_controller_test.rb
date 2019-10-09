require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create(name: "Hermione Granger", phone_num: "904-000-000")
  end
  
  describe "index" do
    it "can get the list of passengers and repond with success" do
      get passengers_path 
      
      must_respond_with :success
    end

    it "responds with success when there is no passengers saved" do
      expect (Passenger.count).must_equal 1
      
      Passenger.destroy_all
      expect (Passenger.count).must_equal 0

      get passengers_path 
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    # Your tests go here
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
