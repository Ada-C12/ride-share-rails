require "test_helper"

describe Trip do
  it "can be instantiated" do
    passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
    driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
    trip_info = {
      trip: {   
        driver_id: driver.id,
        passenger_id: passenger.id,
        date: Time.now,
        rating: 2,
        cost: 100,}
      }

    new_trip = Trip.new(trip_info[:trip])
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
    driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
    trip_info = {
      trip: {   
        driver_id: driver.id,
        passenger_id: passenger.id,
        date: Time.now,
        rating: 2,
        cost: 100,}
      }

    new_trip = Trip.new(trip_info[:trip])
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a passenger" do
      passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      trip_info = {
        trip: {   
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Time.now,
          rating: 2,
          cost: 100,}
        }
  
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      assert_not_nil(new_trip.passenger_id)
    end

    it "belongs to a driver" do
      passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      trip_info = {
        trip: {   
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Time.now,
          rating: 2,
          cost: 100,}
        }
  
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      assert_not_nil(new_trip.driver_id)
    end
  end

  describe "validations" do
    it "must have a passenger" do
      passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      trip_info = {
        trip: {   
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Time.now,
          rating: 2,
          cost: 100,}
        }
  
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      assert_not_nil(new_trip.passenger_id)
    end

    it "must have a driver" do
      passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      trip_info = {
        trip: {   
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Time.now,
          rating: 2,
          cost: 100,}
        }
  
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      assert_not_nil(new_trip.driver_id)
    end

    it "must have a date" do
      passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      trip_info = {
        trip: {   
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Time.now,
          rating: 2,
          cost: 100,}
        }
  
      new_trip = Trip.new(trip_info[:trip])
      new_trip.save
      assert_not_nil(new_trip.date)
    end
  end

end
