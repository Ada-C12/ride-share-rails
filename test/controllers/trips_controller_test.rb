require "test_helper"

describe TripsController do
  let (:passenger_a) {
    Passenger.create(name: "Bob Ross", phone_num: "1234567891")
  }
  let (:driver_a) {
    Driver.create(name: "Dory", vin: "1234567890")
  }

  let (:trip) {
    Trip.create(date: Date.today, passenger_id: passenger_a.id, driver_id: driver_a.id)
  }
  describe "show" do
    it "responds with success when showing an existing trip id" do
      get trip_path(trip.id)

      must_respond_with :success
    end
    it "responds with 404 when showing an invalid trip id" do
      get trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "create" do
    # Your tests go here
    let (:passenger) {
      Passenger.new(name: "SpongeBob SquarePants", phone_num: "1345679765")
    }
    let (:driver) {
      Driver.new(name: "Mr.Krabs", vin: "7976534567")
    }
    it "can create a new trip with valid information accurately, and redirect" do
      passenger.save
      driver.save
      first_driver = Driver.first
      first_passenger = Passenger.first

      trip_hash = {
        passenger_id: first_passenger.id,
      }

      expect {
        post trips_path, params: trip_hash
      }.must_differ "Trip.count", 1
      must_redirect_to trip_path(Trip.find_by(passenger_id: first_passenger.id).id)
    end

    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      trip_hash = {
        passenger_id: "",
      }

      expect {
        post trips_path, params: trip_hash
      }.must_differ "Trip.count", 0

      must_redirect_to passengers_path
    end
  end

  describe "edit" do
    # Your tests go here
    it "responds with success when getting the edit page for an existing, valid trip" do
      get edit_trip_path(trip.id)

      must_respond_with :success
    end
    it "responds with redirect when getting the edit page for an invalid trip id" do
      get edit_trip_path(-1)

      must_redirect_to root_path
    end
  end

  describe "update" do
    # Your tests go here
   

    it "can update an existing trip with valid information accurately, and redirect" do
      old_trip = trip 
      trip_hash = {
        trip: {
          rating:"5",
          cost: "1000"
        },
      }
    
     
      expect {
        patch trip_path(old_trip.id), params: trip_hash 
      }.must_differ "Trip.count", 0

   
      found_trip = Trip.find_by(id: old_trip.id)
      
      expect(found_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(found_trip.cost).must_equal trip_hash[:trip][:cost]

      must_respond_with :redirect
      must_redirect_to trip_path(found_trip.id)
    end
    it "does not update with invalid id and redirects" do
      old_trip = trip 
      trip_hash = {
        trip: {
          rating:"5",
          cost: "1000"
        },
      }
    
     
      expect {
        patch trip_path(-1), params: trip_hash 
      }.must_differ "Trip.count", 0

   
      found_trip = Trip.find_by(id: old_trip.id)
      
      expect(found_trip.rating).must_be_nil 
      expect(found_trip.cost).must_be_nil  

      must_respond_with :redirect
      must_redirect_to root_path 
    end
  end

  describe "destroy" do
    # Your tests go here
    it "destroys the trip instance in db when trip exists, then redirects" do
      
      old_trip = trip 

      expect {
        delete trip_path(trip.id)
      }.must_differ "Trip.count", -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
    it "does not change db when trip does not exists, then redirects" do
      
      old_trip = trip 

      expect {
        delete trip_path(-1)
      }.must_differ "Trip.count", 0

      must_respond_with :redirect
      must_redirect_to root_path
    end
    it "does not change db when trying to delete same trip twice, then redirects" do
      
      old_trip = trip 
      Trip.destroy_all

      expect {
        delete trip_path(old_trip.id)
      }.must_differ "Trip.count", 0

      must_respond_with :redirect
      must_redirect_to root_path
    end


  end
end
