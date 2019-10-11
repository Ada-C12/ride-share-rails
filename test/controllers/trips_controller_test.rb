require "test_helper"

describe TripsController do
  describe "index" do
    it "response with success when there are many trips saved" do
      Trip.create driver_id: 1, passenger_id: 1
      
      get trips_path
      
      must_respond_with :success
    end
    
    it "responds with success when there are no trips saved" do
      get trips_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing a valid trip" do
      driver = Driver.create(name:"driver", vin: "1235")
      passenger = Passenger.create(name:"Pass", phone_num: "2323424234")
      
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id)
      
      get trip_path(trip.id)
      
      must_respond_with :success
    end
    
    it "responds with a redirect when trip id invalid" do
      get trip_path(-4)
      
      must_respond_with :redirect
    end
  end
  
  describe "create" do
    it "can create a new trip with valid information and redirect" do
      driver = Driver.create(name:"driver1", vin: "12356")
      passenger = Passenger.create(name:"Passe", phone_num: "23234242340")
      
      trip_hash = {
        trip: {
        passenger_id: passenger.id,
        driver_id: driver.id
        }
      }
      puts "trip passenger id #{trip_hash[:trip][:passenger_id]}"
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1

      expect(Trip.last.passenger.id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to trip_path(Trip.last.id)
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      driver = Driver.create(name:"driver", vin: "1235")
      passenger = Passenger.create(name:"Pass", phone_num: "2323424234")
      
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id)

      get edit_trip_path(trip.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_trip_path(-50)

      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      driver = Driver.create(name:"driver1", vin: "12356")
      passenger = Passenger.create(name:"Passe", phone_num: "23234242340")
      Trip.create(driver_id: driver.id, passenger_id: passenger.id)
    end

    let (:new_trip_hash) {
      {
        trip: {
          rating: 5
        }
      }
    }
    it "can update an existing trip's rating with valid information and redirect" do
      id = Trip.last.id
      expect {
        patch trip_path(id), params: new_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect

      trip = Trip.find_by(id: id)
      expect(trip.rating).must_equal new_trip_hash[:trip][:rating]
    end

    it "will respond with not_found for invalid ids" do
      id = -10

      expect {
        patch trip_path(id), params: new_trip_hash
      }.wont_change "Trip.count"

      must_respond_with :redirect
    end

    it "will not update if params " do
      id = Trip.last.id
      original_trip = Trip.find_by(id: id)

      expect {
        patch trip_path(id), params: {}
      }.must_raise

      trip = Trip.find_by(id: id)
      expect(trip.id).must_equal original_trip.id
      expect(trip.cost).must_equal original_trip.cost
      expect(trip.passenger_id).must_equal original_trip.passenger_id
      expect(trip.driver_id).must_equal original_trip.driver_id
    end
  end

  describe "destroy" do
    it "deletes an existing instance of trip and redirects to root page" do

      driver = Driver.create(name:"driver1", vin: "12356")
      passenger = Passenger.create(name:"Passe", phone_num: "23234242340")

      Trip.create(driver_id: driver.id, passenger_id: passenger.id)

      existing_trip_id = Trip.last

      expect {
        delete trip_path(existing_trip_id)
      }.must_differ "Trip.count", -1

      must_redirect_to root_path
    end
  end

end



#   describe "driver trip availability" do

#     it "can show a driver is active aka true/on a trip" do
#       # Arrange
#       new_driver = Driver.create(name: "Kari", vin: "123")
#       # expect(new_driver.active).must_equal nil

#       new_passenger = Passenger.create(name: "Pass", phone_num: "1234567")

#       new_trip = {
#       trip: {
#       date: Time.now, driver_id: new_driver.id, passenger_id: new_passenger.id
#     }
#   }
#   expect {
#   post trips_path, params: new_trip
# }.must_differ "Trip.coun", 1

# Assert


# it "can complete a trip by assigning a rating and allowing driver available again" do

# end
