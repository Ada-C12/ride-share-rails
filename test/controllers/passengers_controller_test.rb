require "test_helper"

describe PassengersController do
  describe "index" do
    get passengers_path
    must_respond_with :success
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
