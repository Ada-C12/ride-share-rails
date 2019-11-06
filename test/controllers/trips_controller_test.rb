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
    
    it "will respond with redirect when attempting to edit a nonexistant trip" do
      #skip
      # Your code here
      get edit_trip_path("9999999999")
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    # Your tests go here
    before do
      rider = Passenger.new(name: "Lila Keating", phone_num: "431-309-4939")
      rider2 = Passenger.new(name: "Granny Smith", phone_num: "455-789-9988")
      taxi = Driver.new(name: "Dale Masters", vin: "456567678")
      taxi2 = Driver.new(name: "Grumpy Frank", vin: "1000678")
      valid_trip = Trip.create(date: Time.now, passenger_id: rider[:id], driver_id: taxi[:id], rating: nil, cost: 1)
    end
    # Note:  If there was a way to fail to save the changes to a trip, that would be a great
    #        thing to test. 
    
    it "updates an existing trip successfully and redirects to home" do
      
      rider = Passenger.new(name: "Lila Keating", phone_num: "431-309-4939")
      rider2 = Passenger.new(name: "Granny Smith", phone_num: "455-789-9988")
      taxi = Driver.new(name: "Dale Masters", vin: "456567678")
      taxi2 = Driver.new(name: "Grumpy Frank", vin: "1000678")
      valid_trip = Trip.create(date: Time.now, passenger_id: rider[:id], driver_id: taxi[:id], rating: nil, cost: 1)
      
      updated_trip_hash = {
        trip: {
          date: Time.now, 
          passenger_id: rider2[:id], 
          driver_id: taxi2[:id], 
          cost: 5
        }
      }
      
      expect {
        patch trip_path(valid_trip[:id]), params: updated_trip_hash
      }.wont_change 'Trip.count'
      
      # Assert
      expect( Trip.find_by(id: existing_trip.id).passenger_id ).must_equal 1
      expect( Trip.find_by(id: existing_trip.id).driver_id ).must_equal 1
    end
    
    
    it "will redirect to the root page if given an invalid id" do
      get trip_path("5000")
      must_respond_with :not_found
    end
  end
  
  describe "destroy" do
    # Your tests go here
    it 'deletes a new trip successfully with valid data, and redirects the user to the trip page' do
      
      trip_hash = {
        trip: {
          date: Time.now, 
          passenger_id: 1, 
          driver_id: 1, 
          cost: 5
        }
      }
      
      post trips_path, params: trip_hash
      identifier = Trip.first
      
      expect {
        delete trip_path(identifier.id)
      }.must_differ 'Trip.count', -1
      
      must_redirect_to trips_path
    end
    
  end
  
end
