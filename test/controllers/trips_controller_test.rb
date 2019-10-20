require "test_helper"

describe TripsController do
  describe "create" do
    it "creates a new trip successfully with valid data, and redirects to the passenger's page" do 
      example_pass = Passenger.create(name: "Snoopy", phone_num: "4")
      example_driver = Driver.create(name: "Charlie Brown", vin: "22", car_make: "doghouse", car_model: "backyard")
      trip_hash = {
        trip: {
          passenger_id: example_pass.id,
          driver_id: example_driver.id,
          rating: nil, 
          date: Date.today, 
          cost: 250
        }
      }
      expect { post passenger_trips_path(example_pass), params: trip_hash}.must_change "Trip.count", 1  
      must_redirect_to passenger_path(example_pass)
    end 
    
    it "does not create a trip from invalid form data, and responds with not_found" do 
      example_pass = Passenger.create(name: "Snoopy", phone_num: "4")
      example_driver = Driver.create(name: "Charlie Brown", vin: "22", car_make: "doghouse", car_model: "backyard")
      bad_trip = { 
        trip: { 
          passenger_id: nil, 
          driver_id: example_driver.id, 
          rating: nil, 
          date: nil,
          cost: 225
        }
      }
      expect { post passenger_trips_path(294738), params: bad_trip }.wont_change "Trip.count"
      must_respond_with :not_found 
    end 
  end 
  
  describe "destroy" do
    it "successfully destroys an existing trip" do
      example_pass = Passenger.create(name: "Snoopy", phone_num: "4")
      example_driver = Driver.create(name: "Charlie Brown", vin: "22", car_make: "doghouse", car_model: "backyard")
      example_trip = Trip.create(passenger_id: example_pass.id, driver_id: example_driver.id, rating: nil, date: Date.today, cost: 250)
      example_trip_id = example_trip.id
      expect { delete trip_path(example_trip.id) }.must_change 'Trip.count', -1
      must_respond_with :redirect
      must_redirect_to passenger_path(example_pass.id)
      
      assert_nil(Trip.find_by(id: example_trip_id))
    end 
  end
end 