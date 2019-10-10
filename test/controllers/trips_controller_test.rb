require "test_helper"

describe TripsController do
  let (:driver1) { Driver.create(name: "Kari", vin: "123") }
  let (:passenger1) { Passenger.create( name: "Ned Flanders", phone_num: "206-123-1234") }
  let (:trip_hash) { { trip: {date: Time.now, rating: 5, driver_id: driver1.id, passenger_id: passenger1.id} } }
  let (:trip1) { Trip.create(trip_hash)}
  
  describe "show" do
    describe "via trips/" do
      it "Can show individual trip page if trip id valid" do
        trip1
        puts trip1.attributes
      end
      
      it "Redirects if trip id invalid" do
        get trip_path(id: -666)
        must_redirect_to nope_path(msg: "No such trip exists!")
      end
    end
    
    describe "via passengers/:passenger_id/trips" do
      it "Can show individual trip page if trip id valid" do
        ###
      end
      
      it "Redirects if trip id invalid" do
        ###
      end
    end
  end
  
  describe "create" do
  
    it "" do
      # Your tests go here
    end

    it "" do
      # Your tests go here
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
