require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many drivers saved" do
      test_passenger = Passenger.create
      get passengers_path
      must_respond_with :success
    end
    it "responds with success when there are no passengers saved" do
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    before do
      @test_passenger = Passenger.create
    end
    it "responds with success when showing an existing valid passenger" do
      get passenger_path(@test_passenger.id) 
      must_respond_with :success
    end
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "new" do
    it "can get the new passenger path" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do    
    it "can can create a new instance of passenger " do
      passenger_hash = {
        passenger: {
          name: "test_passenger",
          phone_num: "1-888-975-5309",
        },
      }
      expect { post passengers_path, params: passenger_hash }.must_change "Passenger.count", 1 
    end
  end
  
  describe "edit" do
    # Your tests go here
  end
  
  describe "update" do
    # Your tests go here
  end
  
  describe "destroy" do
    
    it "destroys passenger and redirects" do
      passenger = Passenger.create
      passenger_id = Passenger.first.id
      expect { delete passenger_path(passenger_id) }.must_change "Passenger.count", -1
      must_respond_with :redirect
    end
    
    it "will respond with 404 if attempting to delete invalid passenger and trip count will be unaffected" do
      expect { delete passenger_path(-9) }.wont_change "Passenger.count"
      must_respond_with :not_found
    end
  end
end