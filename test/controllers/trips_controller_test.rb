require "test_helper"

describe TripsController do
  let (:driver1) { Driver.create(name: "Kari", vin: "123") }
  let (:passenger1) { Passenger.create( name: "Ned Flanders", phone_num: "206-123-1234") }
  let (:trip_hash) { {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: passenger1.id, cost: 100} }
  let (:trip_hash_bad_driver) { {date: Time.now, rating: 5, driver_id: -666, passenger_id: passenger1.id, cost: 100} }
  let (:trip_hash_no_driver) { {date: Time.now, rating: 5, driver_id: nil, passenger_id: passenger1.id, cost: 100} }
  let (:trip_hash_bad_passenger) { {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: -666, cost: 100} }
  let (:trip_hash_no_passenger) { {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: nil, cost: 100} }
  let (:trip_hash_no_date) { {date: nil, rating: nil, driver_id: driver1.id, passenger_id: passenger1.id, cost: 100} }
  let (:trip_hash_no_cost) { {date: Time.now, rating: nil, driver_id: driver1.id, passenger_id: passenger1.id, cost: nil} }
  let (:trip1) { Trip.create(trip_hash)}
  
  describe "show, via trips/:id" do
    # Hey Momo!! This feels kinda short, am I forgetting something?
    it "Can show individual trip page if trip id valid" do
      get trip_path(id: trip1.id)
      must_respond_with :success
    end
    
    it "Redirects if trip id invalid" do
      get trip_path(id: -666)
      must_redirect_to nope_path(msg: "No such trip exists!")
    end
  end
  
  describe "create" do
    
    it "can create correct trip object given good input" do
      expect{trip1}.must_differ "Trip.count", 1
      assert(trip1.driver_id == driver1.id)
      assert(trip1.passenger_id == passenger1.id)
      assert(trip1.date == trip_hash[:date])
      assert(trip1.cost == trip_hash[:cost])
      assert(trip1.rating == trip_hash[:rating])
    end
    
    it "won't create correct trip object given bad input, and will give error msgs" do
      set_of_bad_params = [
      trip_hash_bad_driver,
      trip_hash_bad_passenger,
      trip_hash_no_driver,
      trip_hash_no_passenger,
      trip_hash_no_date,
      trip_hash_no_cost ]
      trip_count_before = Trip.count
      set_of_bad_params.each do |bad|
        @bad_trip = Trip.create(bad)
        trip_count_after = Trip.count
        assert (trip_count_before == trip_count_after)
        assert (@bad_trip.errors.messages.count > 0)
        # Reactivate line below to see them messages
        # puts @bad_trip.errors.messages
      end
    end
    
    it "after creating trip object, will send to trip_path" do
      post trips_path, params: trip_hash
      must_redirect_to trip_path(id: Trip.last.id)
    end
    
    it "edge: if bad driver input, send to nope_path" do
      post trips_path, params: trip_hash_bad_driver
      must_redirect_to nope_path(msg: "No drivers available, maybe you should walk")
      
      post trips_path, params: trip_hash_no_driver
      must_redirect_to nope_path(msg: "No drivers available, maybe you should walk")
    end
    
    it "edge: if bad passenger input, send to nope_path" do
      post trips_path, params: trip_hash_bad_passenger
      must_redirect_to nope_path(msg: "Trip request unsuccessful, please contact customer service at 1-800-lol-sorry")
      
      post trips_path, params: trip_hash_no_passenger
      must_redirect_to nope_path(msg: "Trip request unsuccessful, please contact customer service at 1-800-lol-sorry")
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
