require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create name: "Meatball Jones", vin: "1234", active: true, car_make: "Honda", car_model: "Accord"
    @passenger = Passenger.create name: "Squidward Squid", phone_number: "123-456-7890"
    
    @trip = Trip.create date: Date.new(2019,10,8), passenger_id: Passenger.first.id, driver_id: Driver.first.id, cost: "2310", rating: "4"
  end
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      get trip_path(@trip.id)
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip id" do
      get trip_path("carrot")
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      trip_hash = {
        trip: {
          date: Date.new(2019,2,3),
          passenger_id: Passenger.first.id,
          driver_id: Driver.first.id,
          cost: "1234"
        },
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      
      created_trip = Trip.last
      expect(created_trip.date).must_equal trip_hash[:trip][:date]
      expect(created_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]
      expect(created_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
      expect(created_trip.cost).must_equal trip_hash[:trip][:cost]
      
      must_respond_with :redirect
      must_redirect_to trip_path(created_trip.id)
    end
    
    it "raises an error when trip creation form does not include date" do
      trip_hash = {
        trip: {
          passenger_id: Passenger.first.id,
          driver_id: Driver.first.id,
          cost: "1234"
        },
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_raise
    end
    
    it "raises an error when trip creation form does not include cost" do
      trip_hash = {
        trip: {
          date: Date.new(2019,2,3),
          passenger_id: Passenger.first.id,
          driver_id: Driver.first.id,
        },
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_raise
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
    end
  end
  
  describe "update" do
    it "can update an existing trip with valid information from edit form parameters accurately, and redirect" do
    end
    
    it "can update an existing trip with valid information from edit form parameters accurately, and redirect" do
    end
    
    it "does not update any trip if given an invalid id, and responds with a 404" do
    end
    
    it "does not create a trip if the form data violates Driver validations, and responds with a redirect" do
    end
  end
  
  describe "destroy" do
    # Your tests go here
  end
  
  describe "assign_ratings_edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
    end
  end
end
