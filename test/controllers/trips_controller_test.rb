require "test_helper"

describe TripsController do
  before do
    @sample = Trip.create date: Time.now, passenger_id: 1, driver_id: 1, cost: 5, rating: nil
  end
  
  describe "show" do
    it 'responds with a success when id given exists' do
      
      valid_trip = Trip.create(date: Time.now, passenger_id: 1, driver_id: 1, rating: nil, cost: 5)
      
      get trips_path(valid_trip.id)
      must_respond_with :success
      
    end
    
    it 'responds with a not_found when id given does not exist' do
      
      get trip_path("-1")
      must_respond_with :not_found
      
    end
  end
  
  describe "create" do
    it 'creates a new trip successfully with valid data, and redirects the user to the passenger page' do
      
      trip_hash = {
        trip: {
          date: Time.now, 
          passenger_id: 1, 
          driver_id: 1, 
          cost: 5
        }
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      
      must_redirect_to trips_path
    end
  end
  
  describe "edit" do
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Your code here
      get edit_trip_path("9999999999")
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    # Your tests go here
  end
  describe "destroy" do
    # Your tests go here
  end
end
