require "test_helper"

describe TripsController do
  let (:example_trip) { Trip.new( passenger_id: 1, driver_id: 2, rating: nil, date: Date.today, cost: 250) }
  
  describe "show" do
    it "responds with a success when id given exists" do 
      trip_1 = Trip.create( passenger_id: 1, driver_id: 2, rating: nil, date: Date.today, cost: 250)
      get trip_path(id: trip_1.id)
      must_respond_with :success
    end 
    
    it "responds with a not_found when id given doesn't exist" do
      get trip_path(-5938)
      must_respond_with :not_found
    end 
  end
  
  describe "create" do
  
    it "creates a new trip successfully with valid data, and redirects to the passenger's trip page" do 
      trip_hash = {
        trip: {
          passenger_id: 1,
          driver_id: 1,
          rating: nil, 
          date: Date.today, 
          cost: 250
        }
      }
      expect { post passengers_trip_path, params: trip_hash}.must_change "Trip.count", 1  
      must_redirect_to passenger_path(1)
    end 

    it "does not create a trip from invalid form data, and responds with not_found" do 
      bad_trip = { trip: { passenger_id: nil, driver_id: nil, rating: nil, date: Date.today, cost: 225}}

      expect { post passengers_path, params: bad_pass }.wont_change "Trip.count"
      must_respond_with :not_found 
    end 
  end 

  describe "edit" do
    #I don't think we want to edit a trip, besides assign it a rating.
  end
  
  describe "update" do
    # Also not sure about update
  end
  
  describe "destroy" do
      deleted_trip_passenger = example_trip.passenger
      expect { delete trip_path(example_trip.id) }.must_change 'Trip.count', -1
      must_respond_with :redirect
      must_redirect_to passenger_path(deleted_trip_passenger.id)

      get trip_path(example_trip.id)
      must_respond_with :missing
    end 
  end
end 