require "test_helper"

describe TripsController do
  describe "show" do
    it "can get the index path" do
      get trips_path
      
      must_respond_with :success
    end
    
    it "can get the root path" do
      get root_path
      
      must_respond_with :success
    end
  end
  
  #To-do test to create with passenger
  describe "create" do
    it "can create a new trip" do
      passenger = Passenger.create(name: "Kelsey", phone_num: "222-222-2222")
      driver = Driver.create(name: "Brianna", vin: "1234567890")
      trip_hash = {
      trip: {
      date: "2019-10-5",
      rating: 2,
      cost: 4,
      passenger_id: passenger.id,
      driver_id: driver.id
    }
  }
  
  expect {
  post trips_path, params: trip_hash
}.must_change "Trip.count", 1

new_trip = Trip.find_by(date: trip_hash[:trip][:date])
expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
expect(new_trip.cost).must_equal trip_hash[:trip][:cost]

must_respond_with :redirect
must_redirect_to trip_path(new_trip.id)
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
