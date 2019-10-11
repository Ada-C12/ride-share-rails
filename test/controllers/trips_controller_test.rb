require "test_helper"

describe TripsController do
  describe "show" do
    it 'responds with a success when id given exists' do
      
      valid_trip = Trip.create(date: Time.now, passenger_id: 1, driver_id: 1, rating: nil, cost: 5)
      
      get trip_path(valid_trip.id)
      must_respond_with :success
      
    end
    
    # it 'responds with a not_found when id given does not exist' do
    
    #   get passenger_path("5000")
    #   must_respond_with :not_found
    
    # end
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
