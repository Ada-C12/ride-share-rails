require "test_helper"

describe TripsController do
  
  describe "show" do
    it "responds with a success when id given exists" do 
      example_pass = Passenger.create(name: "Snoopy", phone_num: "4")
      example_driver = Driver.create(name: "Charlie Brown", vin: "22", car_make: "doghouse", car_model: "backyard")
      example_trip = Trip.create(passenger_id: example_pass.id, driver_id: example_driver.id, rating: nil, date: Date.today, cost: 250)
      get trip_path(example_trip.id)
      must_respond_with :success
    end
    it "responds with a not_found when id given doesn't exist" do
      get trip_path(-5938)
      must_respond_with :not_found
    end 
  end
  
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
    expect { delete trip_path(example_trip.id) }.must_change 'Trip.count', -1
    must_respond_with :redirect
    must_redirect_to passenger_path(example_pass.id)

    get trip_path(example_trip.id)
    must_respond_with :missing
    end 
  end
end 