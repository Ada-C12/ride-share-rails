require "test_helper"

describe TripsController do
  describe "show" do
    before do
      @test_trip = Trip.create
    end
    
    it "shows accurate information about a trip" do
      
      get trips_path(Trip.find_by(id: @test_trip.id))
      
      must_respond_with :success
      
    end
    
    it "redirects to 404 not found if asked to show information about a trip with an invalid ID" do
      
      get trip_path(-1)
      
      must_respond_with :not_found
      
    end
    
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
