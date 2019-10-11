require "test_helper"

describe PassengersController do
  describe "index" do
    it "gives back a susccesful response" do
      get passengers_path

      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end

  end

  describe "show" do
    it "gives back a successful response" do
      valid_passenger = Passenger.create(name: "Georgina", phone_num:"425449888")
      get passenger_path(valid_passenger.id)
      must_respond_with :success
    end

    it "gives back a 404 response if they try an invalid id" do
      get passenger_path("100000")
      must_respond_with :not_found
    end
    
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      second_passenger = Passenger.create(name: "Kristina", phone_num:"425449888")
      get edit_passenger_path(second_passenger.id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @existing_passenger = Passenger.create(name: "Devin", phone_num:"425449888")
      @updated_passenger_form_data = {
        passenger: {
          name: "Becca",
          phone_num: "345920292",
        }
      }
    end

    it "can update an existing passenger" do
      patch passenger_path(@existing_passenger.id), params: @updated_passenger_form_data

      expect(Passenger.find_by(id: @existing_passenger.id).name).must_equal "Becca"
      expect(Passenger.find_by(id: @existing_passenger.id).phone_num).must_equal "345920292"
    end

    it "can't update an existing passenger giving wrong parameters" do
      wrong_passenger_form_data = {
        passenger: {
          names: "Becca",
          phone_numsss: "345920292",
        }
      }
      patch passenger_path(@existing_passenger.id), params: wrong_passenger_form_data

      expect(Passenger.find_by(id: @existing_passenger.id).name).must_equal "Devin"
      expect(Passenger.find_by(id: @existing_passenger.id).phone_num).must_equal "425449888"
    end

    it "will respond with not_found if given an invalid id" do
      patch passenger_path(-1), params: @updated_passenger_form_data
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_info = {
        passenger: {
          name: "Chris",
          phone_num: "4254449878",
        },
      }
      expect {
        post passengers_path, params: passenger_info
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_info[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_info[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_info[:passenger][:phone_num]
    end
  end

  describe "destroy" do
    before do
      @passenger_info = {
        passenger: {
          name: "Chris",
          phone_num: "4254449878",
        },
      }
    end

    it "can delete a passenger" do
      old_passenger = Passenger.create(@passenger_info[:passenger])
      expect {
        delete passenger_path(old_passenger.id)
      }.must_change "Passenger.count", 1
    end

    it "will respond with not_found if given an invalid id" do
      patch passenger_path(-1)
      must_respond_with :not_found
    end
  end

  describe "create_new_trip" do
    it "can create a new trip" do
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

      post "/passengers/#{passenger.id}/create_new_trip", params: trip_info
    
      expect(passenger.find_passenger_trips.count).must_equal 1
    end
  end
end
