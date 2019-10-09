require "test_helper"

describe TripsController do
  before do
    @driver = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
    @passenger = Passenger.create name: "Squidward Squid", phone_number: "123-456-7890"
    
    @trip = Trip.create date: Time.now, passenger_id: Passenger.first.id, driver_id: Driver.first.id, cost: "2310", rating: "4"
  end
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      get trip_path(@trip.id)
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip id" do
      get trip_path("carrot")
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    # Your tests go here
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
  
  describe "assign_ratings_edit" do
    # Your tests go here
  end
end
