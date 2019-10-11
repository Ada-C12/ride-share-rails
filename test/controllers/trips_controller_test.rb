require "test_helper"

describe TripsController do
  let (:example_trip) { Trip.create( passenger_id: 1, driver_id: 2, rating: nil, date: Date.today, cost: 250) }
  
  describe "show" do
    it "responds with a success when id given exists" do 
      get trip_path(example_trip.id)
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

      sally = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(sally.name).must_equal passenger_hash[:passenger][:name]
      expect(sally.phone_num).must_equal passenger_hash[:passenger][:phone_num]
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
