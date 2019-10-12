require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
  end
  
  describe "create" do
    it "can change driver status offline" do 
      driver = Driver.create(name: "Kari", vin: "123")
      
      passenger = Passenger.create(name: "Jessica", phone_num: 334-876-2345)
      
      post passenger_trips_path(passenger.id)
      
      trip = Trip.find_by(passenger_id: passenger.id)
      
      
      expect(trip.driver.status).must_equal "unavailable"
    end
    
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
end
