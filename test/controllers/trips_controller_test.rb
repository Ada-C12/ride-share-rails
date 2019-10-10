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
    it "can create a new trip for a given passenger for today with a driver"do
      Driver.create
      pass = Passenger.create
      
      expect { post new_trip_path(pass.id) }.must_change "Trip.count", 1
      
      expect(Trip.first.passenger.id).must_equal pass.id

      refute_nil Trip.first.driver
      refute_nil Trip.first.date
      
      must_respond_with :redirect
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
