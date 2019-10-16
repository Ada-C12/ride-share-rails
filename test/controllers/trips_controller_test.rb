require "test_helper"

describe TripsController do
  let (:driver) {
    Driver.create(name: "George", vin: "123456789")
  }
  
  let (:passenger) {
    Passenger.create(name: "Dolly", phone_num: "360-931-1677")
  }
  
  let (:trip) {
    Trip.create(passenger_id: passenger.id)
  }
  
  describe "new" do
  end
  
  describe "show" do
    it "should show a valid trip" do 
      get trip_path(trip)
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip id" do
      get trip_path(-1)
      must_respond_with :redirect
    end
  end
  
  #   describe "create" do
  #     # let (:driver) {
  #     #   Driver.create name: "George", vin: "123456789"
  #     # }
  
  #     # let (:passenger) {
  #     #   Passenger.create name: "Dolly", phone_num: "360-931-1677"
  #     # }
  
  #     # it "can create a new trip with valid information accurately, and redirect" do
  #     #   the_driver = Driver.find_by(vin: "123456789")
  #     #   the_passenger = Passenger.find_by(phone_num: "360-931-1677")
  #     #   trip_params = {
  #     #     trip: {
  #     #       passenger_id: the_passenger.id, driver_id: the_driver.id, date: Date.today, cost: 222, rating: nil
  #     #     }
  #     #   }
  #     #   expect {
  #     #     create trip_path, params: trip_params
  #     #   }.must_differ "Trip.count", 1
  #   end
  # end
  
  # describe "edit" do
  #   let (:driver) {
  #     Driver.create(name: "George", vin: "123456789")
  #   }
  
  #   let (:passenger) {
  #     Passenger.create(name: "Dolly", phone_num: "360-931-1677")
  #   }
  
  #   let (:trip) {
  #     Trip.create(passenger_id: passenger.id)
  #   }
  
  #   it "responds with success when updating a trip" do
  #     patch trip_path(trip)
  #     must_respond_with :success
  #   end
  
  #   it "successfully updates a trip" do
  
  #   end
  # end
  
  # describe "update" do
  #   # Your tests go here
  # end
  
  # describe "destroy" do
  #   # Your tests go here
end

