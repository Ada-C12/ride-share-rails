require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create name: "Meatball Jones", vin: "1234", active: false, car_make: "Honda", car_model: "Accord"
    @passenger = Passenger.create name: "Squidward Squid", phone_number: "123-456-7890"
    
    @trip = Trip.create date: Date.new(2019,10,8), passenger_id: Passenger.first.id, driver_id: Driver.first.id, cost: "2310"
  end
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      get trip_path(@trip.id)
      must_respond_with :success
    end
    
    it "will redirect to not_found for an invalid trip id" do
      get trip_path("carrot")
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    it "can create a new trip with valid passenger_id, toggles driver status, and redirect" do
      expect(Driver.count).must_equal 1
      expect(Driver.first.active).must_equal false
      
      id = Passenger.first.id
      
      expect {
        post passenger_trips_path(passenger_id: id)
      }.must_change "Trip.count", 1
      
      created_trip = Trip.last
      expect(created_trip.passenger_id).must_equal id
      expect(created_trip.driver.active).must_equal true
      
      must_respond_with :redirect
      must_redirect_to trip_path(created_trip.id)
    end
    
    it "will redirect for an invalid passenger id" do
      expect {
        post passenger_trips_path(passenger_id: "carrot")
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end
    
    it "responds with not found when getting the edit page for a non-existing trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "update from edit form" do
    let (:changes_hash) {
      {
        trip: {
          date: Date.new(2019,2,3),
          passenger_id: Passenger.first.id,
          driver_id: Driver.first.id,
          cost: "5678",
          rating: "2"
        },
      }
    }
    
    it "can update an existing trip with valid information from edit form parameters accurately, and redirect" do
      expect {
        patch trip_path(@trip.id), params: changes_hash
      }.wont_change "Trip.count"
      
      must_respond_with :redirect
      
      updated_trip = Trip.find_by(id: @trip.id)
      
      expect(updated_trip.date).must_equal changes_hash[:trip][:date]
      expect(updated_trip.passenger_id).must_equal changes_hash[:trip][:passenger_id]
      expect(updated_trip.driver_id).must_equal changes_hash[:trip][:driver_id]
      expect(updated_trip.cost).must_equal changes_hash[:trip][:cost]
      expect(updated_trip.rating).must_equal changes_hash[:trip][:rating]
    end
    
    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect {
        patch trip_path(-1), params: changes_hash
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
    
    it "will not update if params hash does not include changes" do
      existing_trip = Trip.find_by(id: @trip.id)
      
      expect {
        patch trip_path(existing_trip.id), params: {}
      }.must_raise
      
      updated_trip = Trip.find_by(id: @trip.id)
      
      expect(updated_trip.date).must_equal existing_trip[:date]
      expect(updated_trip.passenger_id).must_equal existing_trip[:passenger_id]
      expect(updated_trip.driver_id).must_equal existing_trip[:driver_id]
      expect(updated_trip.cost).must_equal existing_trip[:cost] 
    end
  end
  
  describe "update from assign rating form" do
    before do
      @no_rating_trip = Trip.create date: Date.new(2019,10,9), passenger_id: Passenger.first.id, driver_id: Driver.first.id, cost: "2310"
    end
    
    let (:changes_hash) {
      {
        trip: {
          rating: "4",
        },
      }
    }
    
    it "can update the rating for an existing trip with valid information from form parameter accurately, and redirect" do
      expect {
        patch assign_rating_path(@no_rating_trip.id), params: changes_hash
      }.wont_change "Trip.count"
      
      must_respond_with :redirect
      
      updated_trip = Trip.find_by(id: @no_rating_trip.id)
      
      expect(updated_trip.rating).must_equal changes_hash[:trip][:rating]
    end
    
    it "does not update any trip if given an invalid id, and responds with a 404" do
      expect {
        patch assign_rating_path(-1), params: changes_hash
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
    
    it "does not update a trip if the form data does not include rating data, and responds with a redirect" do
      existing_trip = Trip.find_by(id: @trip.id)
      
      expect {
        patch assign_rating_path(existing_trip.id), params: {}
      }.must_raise
      
      updated_trip = Trip.find_by(id: existing_trip.id)
      
      expect(updated_trip.date).must_equal existing_trip[:date]
      expect(updated_trip.passenger_id).must_equal existing_trip[:passenger_id]
      expect(updated_trip.driver_id).must_equal existing_trip[:driver_id]
      expect(updated_trip.cost).must_equal existing_trip[:cost] 
      expect(updated_trip.rating).must_be_nil
    end
  end
  
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      id = @trip.id
      
      expect { delete trip_path(id) }.must_change 'Trip.count', -1
      
      destroyed_trip = Trip.find_by(id: id)
      
      expect(destroyed_trip).must_be_nil
      
      must_respond_with :redirect
    end
    
    it "does not change the db when the trip does not exist, then responds with a 404" do
      delete trip_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "assign_ratings_edit" do
    it "responds with success when getting the assign_ratings_edit page for an existing, valid trip" do
      get assign_rating_edit_path(@trip.id)
      must_respond_with :success
    end
    
    it "responds with not found when getting the edit page for a non-existing trip" do
      get assign_rating_edit_path(-1)
      must_respond_with :not_found
    end
  end
end
