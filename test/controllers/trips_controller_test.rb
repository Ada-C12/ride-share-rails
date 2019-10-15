require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "sample driver", vin: "14353")
  }
  
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_num: "333333333")
  }
  
  let (:trip) {
    Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 3, cost: 533)
  }
  
  describe "show" do
    it "can get a valid trip" do
      get trip_path(trip.id)
      must_respond_with :success
    end
    
    it "will return a not found error for an invalid trip" do
      get trip_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_trip_path(trip.id)
      must_respond_with :success
    end
    
    it "will respond with not found when edit a nonexistant trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    it "can update an existing trip" do
      new_trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, rating: 4, cost: 999)
      
      updated_trip_form_data = {
        trip: {
          rating: 2,
          cost: 988 },
        }
        
        patch trip_path(new_trip.id), params: updated_trip_form_data
        
        expect(Trip.find_by(id: new_trip.id).rating).must_equal 2
        expect(Trip.find_by(id: new_trip.id).cost).must_equal 988
      end
      
      it "can't update an existing trip with wrong params" do 
        new_trip = Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, rating: 4, cost: 999)
        
        bad_trip_form_data = {
          trip: {
            rating: 10,
          },
        }
        
        patch trip_path(new_trip.id), params: bad_trip_form_data
        expect(Trip.find_by(id: new_trip.id).rating).must_equal 4
      end 
    end
    
    describe "create a trip/request a ride" do
      it "can create a new trip with valid information accurately, and redirect" do
        new_passenger = Passenger.create(name: "new passenger", phone_num: "44444444")
        new_driver = Driver.create(name: "new driver", vin: "HAPPY345")
        
        trip_hash = {
          trip: {
            passenger_id: new_passenger.id,
            driver_id: new_driver.id,
            date: Date.today,
            rating: nil,
            cost: 599
          }
        }
        
        expect {
          post passenger_trips_path(new_passenger), params: trip_hash
        }.must_change "Trip.count", -1
        
        must_respond_with :redirect
        must_redirect_to passenger_path(new_passenger.id)
      end
    end
    
    describe "destroy" do
      it "can delete an existing trip" do
        existing_driver = Driver.create(name: "existing driver", vin: "44444444")
        existing_passenger = Passenger.create(name: "existing passenger", phone_num: "123455")
        existing_trip = Trip.create(passenger_id: existing_passenger.id, driver_id: existing_driver.id, date: Date.today, rating: 4, cost: 999)
        
        # old_count = Trip.count
        
        expect { 
          delete trip_path(existing_trip.id)
        }.must_change "Trip.count", -1
      end
    end
  end 
  