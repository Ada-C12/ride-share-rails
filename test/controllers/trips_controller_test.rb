require "test_helper"

describe TripsController do
  describe "show" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    before do
      @passenger = Passenger.create(name: "Georgina", phone_num: "111-111-1211")
      @driver = Driver.create(name: "Lex", vin: "123", active: true, car_make: "Cherry", car_model: "DR5")
      @existing_trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Time.now, rating: 4, cost: 100)
      @updated_trip_form_data = {
        trip: {
          rating: 1,
          cost: 900,
        }
      }
    end

    it "can update an existing trip" do
      patch trip_path(@existing_trip.id), params: @updated_trip_form_data

      expect(Trip.find_by(id: @existing_trip.id).rating).must_equal 1
      expect(Trip.find_by(id: @existing_trip.id).cost).must_equal 900
    end

    it "can't update an existing trip given the wrong parameters" do
      wrong_trip_form_data = {
        trip: {
          ratinsg: 2,
          costs: 89000,
        }
      }
      patch trip_path(@existing_trip.id), params: wrong_trip_form_data

      expect(Trip.find_by(id: @existing_trip.id).rating).must_equal 4
      expect(Trip.find_by(id: @existing_trip.id).cost).must_equal 100
    end

    it "will respond with not_found if given an invalid id" do
      patch trip_path(-1), params: @updated_trip_form_data
      must_respond_with :not_found
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
