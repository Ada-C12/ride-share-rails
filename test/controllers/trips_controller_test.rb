require "test_helper"

describe TripsController do
  describe "show" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 4,
          cost: 100,
        },
      }
    end

    it "gives back a successful response" do
    new_trip = Trip.new(@trip_info[:trip])
    new_trip.save
    get trip_path(new_trip.id)
    must_respond_with :success
    end

    it "gives back a 404 response if they try an invalid id" do
      get trip_path("100000")
      must_respond_with :not_found
    end
  end

  describe "edit" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 4,
          cost: 100,
        },
      }
    end
    it "can get the edit the trip" do
      new_trip = Trip.new(@trip_info[:trip])
      new_trip.save
      get edit_trip_path(new_trip.id)
    end

    it "will respond with not_found when attempting to edit a nonexistant trip" do
      get edit_trip_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 4,
          cost: 100,
        },
      }
      @updated_trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 9,
          cost: 200,
        },
      }
    end

    it "can update an existing trip" do
      new_trip = Trip.new(@trip_info[:trip])
      new_trip.save

      patch "/trips/#{(new_trip.id)}", params: @updated_trip_info

      expect(Trip.find_by(id: new_trip.id).rating).must_equal 9
      expect(Trip.find_by(id: new_trip.id).cost).must_equal 200
    end
    
  end

  describe "destroy" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @trip_info = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Time.now,
          rating: 4,
          cost: 100,
        },
      }
    end

    it "can delete a trip" do
      old_trip = Trip.create(@trip_info[:trip])
      expect {
        delete trip_path(old_trip.id)
      }.must_change "Trip.count", 1
    end

    it "will respond with not_found if given an invalid id" do
      patch trip_path(-1)
      must_respond_with :not_found
    end
  end
end
