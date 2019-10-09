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
    it "responds with success when showing an existing valid driver" do
      existing_passenger_id = Passenger.first.id

      get passenger_path(existing_passenger_id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      get passenger_path(-1)

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
