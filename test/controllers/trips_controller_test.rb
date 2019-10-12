require "test_helper"

describe TripsController do
  #Does each trip need me to create a new instance of driver and passenger?
  before do 
    @passenger = Passenger.create(name:"Mr. jared", phone_num:"954-666-6666")

    @driver = Driver.create(name: "Mx. Dee", vin: "324HVGFTUYG")

    @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today)
  end 


  describe "show" do
    it "shows a list of all a passengers trip" do 
      get trip_path(@trip.id)
      must_respond_with :success
    end 
  end

  describe "create" do
    it "successfully creates a new instance of a trip for a passenger" do
      
      trip_hash = {
        trip: {
          driver_id: @driver.id,
          passenger_id: @passenger.id,
          date: Date.today,
        }
      }
      
      expect {post passenger_trips_path(trip_hash[:trip][:passenger_id]), params: trip_hash}.must_change "Trip.count", 1
      must_respond_with :redirect 
      must_redirect_to trip_path(Trip.last.id)
    end 
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do 
      get edit_trip_path(@trip.id)
      must_respond_with :success 
    end

    it "responds with redirect when getting the edit page for nonexisting trip" do 
      get edit_trip_path(-1)
      must_respond_with :not_found
    end 
  end

  describe "update" do
    it "will successfully update a trip with a rating and redirect to the trip page" do 
      extisting_task = Trip.last 
      updated_params = {rating: 4}

      expect { patch trip_path(@trip.id), params:updated_params }.wont_change "Trip.count"

      expect(Trip.find_by(id: existing_task.id).rating).must_equal 4
    end 
  end

  describe "destroy" do
    it "" do 
    end 
  end
end
