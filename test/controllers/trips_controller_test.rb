require "test_helper"
require "pry"

describe TripsController do
  let (:driver1) { Driver.create(name: "Kari", vin: "123") }
  let (:passenger1) { Passenger.create( name: "Ned Flanders", phone_num: "206-123-1234") }
  let (:trip_hash) { {date: Time.now, rating: nil, driver_id: driver1.id, passenger_id: passenger1.id, cost: 1165} }
  let (:trip_hash_bad_driver) { {date: Time.now, rating: 5, driver_id: -666, passenger_id: passenger1.id, cost: 1000} }
  let (:trip_hash_no_driver) { {date: Time.now, rating: 5, driver_id: nil, passenger_id: passenger1.id, cost: 1000} }
  let (:trip_hash_bad_passenger) { {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: -666, cost: 1000} }
  let (:trip_hash_no_passenger) { {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: nil, cost: 1000} }
  let (:trip_hash_no_date) { {date: nil, rating: nil, driver_id: driver1.id, passenger_id: passenger1.id, cost: 1000} }
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
  
  describe "new" do
    it "making new trip via individual passenger" do
      # skipped this and went straight ahead to trip#create b/c don't need further form input
      assert(true)
    end
    
    it "edge: what if someone tries to sneak in via /trips/new?" do
      get '/trips/new'
      must_redirect_to nope_path(msg: "Only passengers can request/create trips!")
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
    
    it "after creating trip object, will flip @driver.active to true" do
      driver1
      db_driver1 = Driver.find_by(id: driver1.id)
      assert(db_driver1.active == false)
      post trips_path, params: trip_hash
      trip = Trip.last
      updated_driver = Driver.find_by(id: trip.driver_id)
      assert (updated_driver.active)
    end
    
    it "in legit cases of no available drivers, will not create trip and send to nope_path" do
      # only 1 available driver in db
      post trips_path, params: trip_hash
      trip_count_before = Trip.count
      # no available driver left in db
      post trips_path, params: trip_hash
      trip_count_after = Trip.count
      assert(trip_count_after == trip_count_before)
      must_redirect_to nope_path(msg: "No drivers available, maybe you should walk")
    end
    
    it "edge: if bad driver input, send to nope_path" do
      post trips_path, params: {trip: trip_hash_bad_driver}
      must_redirect_to nope_path(msg: "No drivers available, maybe you should walk")
      
      post trips_path, params: {trip: trip_hash_no_driver}
      must_redirect_to nope_path(msg: "No drivers available, maybe you should walk")
    end
    
    it "edge: if bad passenger input, send to nope_path" do
      # here's an available driver
      driver1
      trip_count_before = Trip.count
      post trips_path, params: {trip: trip_hash_bad_passenger}
      trip_count_after = Trip.count
      assert(trip_count_before == trip_count_after)
      must_redirect_to nope_path(msg: "Trip request unsuccessful, please contact customer service at 1-800-lol-sorry")
      
      # here's another available driver
      Driver.create(name: "Mr. Smithers", vin: "987")
      post trips_path, params: {trip: trip_hash_no_passenger}
      must_redirect_to nope_path(msg: "Trip request unsuccessful, please contact customer service at 1-800-lol-sorry")
    end
  end
  
  describe "edit" do
    it "Will send to edit page for valid trip_id" do
      get edit_trip_path(id: trip1.id)
      must_respond_with :success
    end
    
    it "Will send to nope_path for invalid trip_id" do
      get edit_trip_path(id: -666)
      must_redirect_to nope_path(msg: "No such trip exists!")
    end
  end
  
  describe "update" do
    describe "only passengers get to update trips (b/c ratings)" do
      it "will update rating AND switch driver back to active:false" do
        
        # verify starting conditions, from creating new trip
        passenger1
        assert(driver1.active == false)
        post trips_path, params:{ date: Time.now, passenger_id: passenger1.id}
        db_trip = Trip.first
        db_driver = Driver.find_by(id: db_trip.driver_id)
        assert(db_driver.active)
        assert(db_trip.rating == nil)
        
        # now update trip, which should update rating & switch driver.active to false
        ratings = [1,2,3,4,5]
        ratings.each do |num|
          patch trip_path(id: db_trip.id), params: {rating: num}
          rated_trip = Trip.find_by(id: db_trip.id)
          assert(rated_trip.rating == num) 
          
          updated_driver = Driver.find_by(id: db_driver.id)
          refute(updated_driver.active)
        end
      end
      
      it "edge case: attempting to update trip with invalid passenger_id" do
        ###########
      end
    end
    
    it "cannot update from main Trip index page" do
      # links are not given for edit.html if at main Trip index page
      # but what about sneaky urls???
      
      # bogus trip id
      patch trip_path(id: -666)
      must_redirect_to nope_path(msg: "No such trip exists!")
      
      # other bogus parameters?
      # not necessary, b/c new Trip instance will never get made if any of its inputs are bogus
      # see test up above for trips#create
    end
  end
  
  describe "destroy" do
    # Only passengers can delete their own trips
    it "can delete legit trips from legit passengers" do
      delete trip_path(id: trip1.id)
      must_redirect_to passenger_path(id: trip1.passenger_id)
    end
    
    it "deleted trips must NOT affect total $ earned/spent per user!" do
      ### manually checked via website, it works!  but test not working
      
      driver = Driver.create(name: "Kari", vin: "123", active: false)
      passenger = Passenger.create(name: "Homer", phone_num: "209-990-9890")
      
      post trips_path, params: {date: "2019-09-01", passenger_id: passenger.id}

      post trips_path, params: {date: "2019-09-02", passenger_id: passenger.id}

      # binding.pry
      driver.reload
      expect(driver.total_earned).must_equal 2136
      delete trip_path(trip1.id)
    
      expect(Driver.find_by(name: "Kari").total_earned).must_equal 2136
      expect(passenger.total_spent).must_equal 3000
    end
    
    it "if deleting nonexistent trip id, send to nope path" do
      delete trip_path(id: -666)
      must_redirect_to nope_path(msg: "No such trip exists!")
    end
    
  end
end
