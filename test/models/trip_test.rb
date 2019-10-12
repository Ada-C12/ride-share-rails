require "test_helper"

describe Trip do
  let (:passenger) { 
    Passenger.create(name: "julia", phone_number: "555") 
  }

  let (:driver) { 
    Driver.create(name: "dani", vin: 2345) 
  }
  
  let (:trip) {
    Trip.new(passenger_id: passenger.id, driver_id: driver.id, rating: nil, cost: 1000, date: Time.now)
  }

  it "can be instantiated" do
    expect(trip.valid?).must_equal true
  end

  it "will have the required fields" do
    trip.save
    trip = Trip.last 
    [:driver_id, :passenger_id, :rating, :cost, :date].each do |field|
      
    # Assert
    expect(trip).must_respond_to field
  end
end

describe "relationships" do
  it "connects a passenger with a driver" do
    trip.save
    # Assert
    expect(passenger.trips.count).must_equal 1
    expect(driver.trips.count).must_equal 1
    expect(driver.trips.first.id).must_equal passenger.trips.first.id
    expect(trip).must_be_instance_of Trip
  end
end

describe "validations" do  
  it "must have a date" do
    trip.save
    trip.date = nil
    
    # Assert
    expect(trip.valid?).must_equal false
    expect(trip.errors.messages).must_include :date
    expect(trip.errors.messages[:date]).must_equal ["can't be blank"]
  end

  it "must have a number as a cost" do
  trip.cost = nil
  
  # Assert
  expect(trip.valid?).must_equal false
  expect(trip.errors.messages).must_include :cost
  expect(trip.errors.messages[:cost]).must_equal ["is not a number", "can't be blank"]
  end
end

# Tests for methods you create should go here
describe "custom methods" do
  let (:trip2) {
    Trip.new(passenger_id: passenger.id, driver_id: driver.id, rating: nil, cost: 1000, date: Time.now)
  }

  it "calculates all trips total for same passenger converted to float in dollar amount" do
    trip.save
    trip2.save

    expect(Trip.trips_total(passenger.id)).must_equal 20.0
  end
end
end
