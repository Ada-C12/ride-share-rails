require "test_helper"

describe TripsController do
  before do
    @passenger = Passenger.create(
      name: "Jane",
      phone_num: "8675309"
    )
    
    @driver = Driver.create(
      name: "Sarah",
      vin: "848485859",
      active: false
    )
    
    @trip = Trip.create(
      date: "10-09-2019",
      rating: 3,
      cost: 2040,
      passenger_id: @passenger.id,
      driver_id: @driver.id
    )
  end
  describe "show" do
    # Your tests go here
  end
  
  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      Trip.destroy_all
      
      trip_hash = {
        trip: {
          date: "10-11-2019",
          rating: 3,
          cost: 1040,
          passenger_id: @passenger.id,
          driver_id: @driver.id
        },
      }
      
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      
      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end
    
  end
  
  
  describe "edit" do
    # Your tests go here
  end
  
  describe "update" do
    # Your tests go here
  end
  
  describe "destroy" do
    it "can destroy an existing trip" do
      old_trip =Passenger.find(@trip.id)
      
      expect {delete trip_path(@trip.id)}.must_change "Trip.count", -1
    end
    
    it "will respond with a redirect when given a passenger that does not exist" do
      delete trip_path(-12)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find trip"
    end
  end
end
