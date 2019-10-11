require "test_helper"

describe TripsController do
  
  describe "show" do
    driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9") 
    trip = Trip.create driver_id: driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234
    
    it "can get a valid trip" do
      
      get trip_path(trip.id)
      
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip" do
      get trip_path(-1)
      
      must_respond_with :redirect
    end
  end
  
  describe "create" do
    it "can create a new trip" do
      driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9") 
      passenger = Passenger.create(name: "George", phone_num: "111-111-1111") 
      trip_hash = {
        trip: {
          date: "2019-05-10",
          rating: 2,
          cost: 4564,
          driver_id: driver.id,
          passenger_id: passenger.id
        }
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_differ "Trip.count", 1
      
      new_trip = Trip.find_by(driver_id: driver.id)
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      
      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end
  end
  
  describe "edit" do
    it "can get the edit page for an existing trip" do
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip = Trip.create(driver_id: new_driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234)
      
      get edit_trip_path(trip.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant trip" do
      get edit_trip_path(646594)
      
      must_respond_with :redirect
      must_redirect_to trips_path
    end
  end
  
  describe "update" do
    new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    updated_driver = Driver.create(name: "George", vin: "ALWSS52P9SDS4LVDE9")
    existing_trip = Trip.create(driver_id: new_driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234)
    
    update_info = {
      trip: {
        rating: 4, 
        driver_id: updated_driver.id
      }
    }
    
    it "can update an existing trip" do
      patch trip_path(existing_trip.id), params: update_info
      
      updated_trip = Trip.find_by(id: existing_trip.id)
      expect(updated_trip.rating).must_equal update_info[:trip][:rating]
      expect(updated_trip.driver_id).must_equal update_info[:trip][:driver_id]
      
      must_respond_with :redirect
      must_redirect_to trip_path(updated_trip.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      patch driver_path(54645656456), params: update_info
      
      must_respond_with 404
    end
    
    it "does not update a trip if validations are not met" do
      invalid_info = {
        trip: {
          rating: 4, 
          driver_id: nil
        }
      }
      patch trip_path(existing_trip.id), params: invalid_info
      
      expect{ patch trip_path(existing_trip.id), params: {trip: invalid_info}}.must_differ "Trip.count", 0
      
      must_respond_with :redirect
      expect(existing_trip.rating).must_equal 5
    end
  end
  
  describe "destroy" do
    driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
    trip = Trip.create(driver_id: driver.id, passenger_id: 2, date: Date.today, rating: 5, cost: 1234)
    
    it "deletes an existing trip successfully" do
      expect {
        delete trip_path( trip.id )
      }.must_differ "Trip.count", -1
      
      must_redirect_to trips_path
    end
    
    it "redirects if trip is not available to delete" do
      expect {
        delete trip_path( 900 )
      }.must_differ "Trip.count", 0
      
      must_redirect_to trips_path
    end
    
    it "redirects if trip has already been deleted" do
      Trip.destroy_all
      expect {
        delete trip_path( trip.id )
      }.must_differ "Trip.count", 0
      
      must_redirect_to trips_path
    end
  end
end
