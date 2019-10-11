require "test_helper"

describe TripsController do
  describe "show" do
    before do
      @test_trip = Trip.create
    end
    
    it "shows accurate information about a trip" do
      
      get trips_path(Trip.find_by(id: @test_trip.id))
      
      must_respond_with :success
      
    end
    
    it "redirects to 404 not found if asked to show information about a trip with an invalid ID" do
      
      get trip_path(-1)
      
      must_respond_with :not_found
      
    end
    
  end
  
  describe "create" do
    it "can create a new trip for a given passenger for today with a driver"do
    driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
    pass = Passenger.create(name: "test_passenger", phone_num: "4385902")
    
    expect { post new_trip_path(pass.id) }.must_change "Trip.count", 1
    
    expect(Trip.first.passenger.id).must_equal pass.id
    
    refute_nil Trip.first.driver
    refute_nil Trip.first.date
    
    must_respond_with :redirect
  end
end

describe "edit" do
  it "resonds with success for editing an existing trip" do
    pass = Passenger.create(name: "test_passenger", phone_num: "4385902")
    driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
    trip = Trip.create(driver_id: driver.id, passenger_id: pass.id)
    
    get edit_trip_path(trip.id)
    must_respond_with :success
  end
  
  it "responds with redirect for an invalid trip" do
    get edit_trip_path(-1)
    must_respond_with :redirect
  end
end

describe "update" do
  it "can update an existing trip accurately and redirect" do
    pass = Passenger.create(name: "test_passenger", phone_num: "4385902")
    driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
    trip = Trip.create(driver_id: driver.id, passenger_id: pass.id)
    params = { trip: { rating: 1 } }
    
    expect{ patch trip_path(trip.id), params: params }.wont_change "Trip.count"
    expect(Trip.find(trip.id).rating.to_i).must_equal params.dig(:trip, :rating)
    must_respond_with :redirect
  end
  
  it "responds 404 rather than update an invalid trip" do
    patch trip_path(-1)
    must_respond_with :not_found
  end
end

describe "destroy" do
  it "destroys trip and redirects" do
    pass = Passenger.create(name: "test_passenger", phone_num: "4385902")
    driver = Driver.create(name: "Popeye Sailor", vin: "8FH204KDLFURNM385")
    trip = Trip.create(driver_id: driver.id, passenger_id: pass.id)
    
    expect{ delete trip_path(trip.id) }.must_change "Trip.count", -1
    
    assert_nil Trip.find_by(id: trip.id)
    must_respond_with :redirect
  end
  
  it "wont_change for invalid trip, responds 404" do
    expect{ delete trip_path(-1) }.wont_change "Trip.count"
    must_respond_with :not_found
  end
end
end
