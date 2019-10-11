require "test_helper"

describe TripsController do
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      # Arrange
      # Ensure that there is a trip saved
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      valid_trip = Trip.create(date: test_date, cost: 300, passenger_id: valid_passenger.id, driver_id: valid_driver.id)
      
      # Act
      get trip_path(valid_trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid trip id" do
      # Arrange
      # Ensure that there is an id that points to no trip
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      valid_trip = Trip.create(date: test_date, cost: 300, passenger_id: 1, driver_id: 1)
      # Act
      
      get trip_path("-1")
      
      # Assert
      must_respond_with :not_found
      
    end
  end
  
  describe "new" do
    it "responds with success" do
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      
      trip_hash = {trip: {date: test_date, cost: 400, driver_id: valid_driver.id, passenger_id: valid_passenger.id, rating: nil}}
      
      get new_trip_path(trip_hash)
      must_respond_with :success
    end
  end
  
  
  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      expect(valid_driver.active).must_be_nil
      
      trip_hash = {trip: {date: test_date, cost: 400, driver_id: valid_driver.id, passenger_id: valid_passenger.id, rating: nil}}
      
      expect {post trips_path, params: trip_hash}.must_differ 'Trip.count', 1
   
      new_trip_id = Trip.find_by(date: test_date).id
      must_redirect_to trip_path(new_trip_id)
      valid_driver = Driver.find_by(id: valid_driver.id)
      expect(valid_driver.active).must_equal true
    end
    
    it "does not create a trip if the form data violates Trip validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Trip validations
      test_date = Date.today
      valid_driver = Driver.create(name: "Jane Doe", vin: "12345678")
      valid_passenger = Passenger.create(name: "Bob Smith", phone_num: "7654321")
      invalid_trip_hash = {trip: {cost: 12.96, date: test_date, driver_id: valid_driver.id}}
      invalid_trip_hash_2 = {trip: {cost: 12.96, date: test_date, passenger_id: valid_passenger.id}}
      invalid_trip_hash_3 = {trip: {cost: 12.96, driver_id: valid_driver.id, passenger_id: valid_passenger.id}}
      invalid_trip_hash_4 = {trip: {date: test_date, driver_id: valid_driver.id, passenger_id: valid_passenger.id}}
      
      # Act-Assert
      # Ensure that there is no change in trip.count
      expect {post trips_path, params: invalid_trip_hash}.must_differ 'Trip.count', 0
      
      # Assert
      # Check that the controller redirects
      must_redirect_to root_path
      
      expect {post trips_path, params: invalid_trip_hash_2}.must_differ 'Trip.count', 0
      must_redirect_to root_path
      
      expect {post trips_path, params: invalid_trip_hash_3}.must_differ 'Trip.count', 0
      must_redirect_to root_path
      
      expect {post trips_path, params: invalid_trip_hash_4}.must_differ 'Trip.count', 0
      must_redirect_to root_path
    end
  
  end
  
  describe "edit" do

    let(:current_trip) {
      driver_id = Driver.create(name: "Jane Doe", vin: "12345678").id
      passenger_id = Passenger.create(name: "Jane Doe", phone_num: "1234567").id
      Trip.create(cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id)}

    it "responds with success when getting the edit page for an existing, valid trip" do
      # Arrange
      # Ensure there is an existing trip saved
      get edit_trip_path(current_trip.id)
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
      new_trip = current_trip
      get edit_trip_path(-1)

      must_respond_with :redirect
    end
  end
  
  describe "update" do
    before do
      @updated_driver_id = Driver.create(name: "Bob Smith", vin: "9999999").id
      @updated_passenger_id = Passenger.create(name: "Emily Rad", phone_num: "44444444").id
      @updated_date = Date.today + 5
    end

    let(:current_trip) {
      driver_id = Driver.create(name: "Jane Doe", vin: "12345678").id
      passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
      Trip.create(cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id)}

    let(:updates) {{trip: {cost: 13.42, date: @updated_date, passenger_id: @updated_passenger_id, driver_id: @updated_driver_id}}}
    let(:invalid_updates_1) {{trip: {cost: 13.42, date: @updated_date, passenger_id: @updated_passenger_id, driver_id: -1}}}
    let(:invalid_updates_2) {{trip: {cost: 13.42, date: @updated_date, passenger_id: -1, driver_id: @updated_driver_id}}}
    let(:invalid_updates_3) {{trip: {cost: 13.42, passenger_id: @updated_passenger_id, driver_id: @updated_driver_id}}}
    let(:invalid_updates_4) {{trip: {date: @updated_date, passenger_id: @updated_passenger_id, driver_id: @updated_driver_id}}}

    it "can update an existing Trip with valid information accurately, and redirect" do
      patch trip_path(current_trip.id), params: updates
      
      updated_trip = Trip.find_by(id: current_trip.id)
      expect(updated_trip.cost).must_equal updates[:trip][:cost]
      expect(updated_trip.date).must_equal updates[:trip][:date]
      expect(updated_trip.passenger_id).must_equal updates[:trip][:passenger_id]
      expect(updated_trip.driver_id).must_equal updates[:trip][:driver_id]

      must_respond_with :redirect
      must_redirect_to trip_path(updated_trip.id)

    end

    it 'successfully updates trips rating if rating provided' do 
      expect(current_trip.rating).must_be_nil
      patch trip_path(current_trip.id), params: {trip: {rating: 5}}
      current_trip.reload
      expect(current_trip.rating).must_equal 5
    end

    it "does not update any trip if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no trip
      # Set up the form data
      patch trip_path(-1), params: updates
      
      # Act-Assert
      # Ensure that there is no change in trip.count
      updated_trip = Trip.find_by(id: current_trip.id)
      expect(updated_trip.cost).wont_equal updates[:trip][:cost]
      expect(updated_trip.date).wont_equal updates[:trip][:date]
      expect(updated_trip.passenger_id).wont_equal updates[:trip][:passenger_id]
      expect(updated_trip.driver_id).wont_equal updates[:trip][:driver_id]
      
      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data so that it violates passenger validations
      
      # Act-Assert
      # Ensure that there is no change in passenger.count
      # Assert
      # Check that the controller redirects
      updated_trip = Trip.find_by(id: current_trip.id)
      expect {patch trip_path(updated_trip.id), params: invalid_updates_1}.must_differ 'Trip.count', 0
      must_respond_with :redirect

      expect {patch trip_path(updated_trip.id), params: invalid_updates_2}.must_differ 'Trip.count', 0
      must_respond_with :redirect

      expect {patch trip_path(updated_trip.id), params: invalid_updates_3}.must_differ 'Trip.count', 0
      must_respond_with :redirect

      expect {patch trip_path(updated_trip.id), params: invalid_updates_4}.must_differ 'Trip.count', 0
      must_respond_with :redirect
    end
  end
  
  describe "destroy" do
    let(:current_trip) {
      driver_id = Driver.create(name: "Jane Doe", vin: "12345678").id
      passenger_id = Passenger.create(name: "Jane Doe", phone_num: "1234567").id
      Trip.create(cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id)}

    it "destroys the trip instance in db when trip exists, then redirects" do
      # Arrange
      # Ensure there is an existing trip saved
      exisiting_trip_id = current_trip.id
      
      # Act-Assert
      # Ensure that there is a change of -1 in trip.count
      
      # Assert
      # Check that the controller redirects
      expect {
        delete trip_path( exisiting_trip_id )
      }.must_differ "Trip.count", -1

      must_redirect_to root_path
    end
    
    it "does not change the db when the trip does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no trip
      
      # Act-Assert
      # Ensure that there is no change in trip.count
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides

      Trip.destroy_all
      invalid_trip_id = 1

      expect {
        delete trip_path( invalid_trip_id )
      }.must_differ "Trip.count", 0

      must_redirect_to trips_path
    end

    it "redirects to trips index page and deletes no trips if deleting a trip with an id that has already been deleted" do
      exisiting_trip_id = current_trip.id
      Trip.destroy_all

      expect {
        delete trip_path( exisiting_trip_id )
      }.must_differ "Trip.count", 0

      must_redirect_to trips_path
    end
  end

  describe "add_rating" do
    let(:current_trip) {
      post drivers_path, params: {driver: {name: "Jane Doe", vin: "12345678"}}
      driver_id = Driver.find_by(name:"Jane Doe").id
      passenger_id = Passenger.create(name: "John Doe", phone_num: "7654321").id
      
      post trips_path, params: {trip: {cost: 12.46, date: Date.today, driver_id: driver_id, passenger_id: passenger_id}}
      
      Trip.find_by(driver_id: driver_id)
    }

    it "successfully responds with success" do
      expect(current_trip.rating).must_be_nil
      get add_rating_path(current_trip.id), params: {trip: {rating: 5}}
      current_trip.reload
      must_respond_with :success
    end

    it "redirects to trip index page if the given trip does not exist" do
      patch add_rating_path(-1), params: {trip: {rating: 5}}
      current_trip.reload
      must_redirect_to trip_path(current_trip.id)
    end

    # it "successfully updates the driver's active status to false and redirects to the trip show page" do
    #   current_trip.reload
    #   expect(current_trip.driver.active).must_equal true
    #   patch add_rating_path(current_trip.id), params: {trip: {rating: 5}}
    #   must_redirect_to trip_path(current_trip.id)
    #   current_trip.reload
    #   expect(current_trip.driver.active).must_equal false
    # end
  end

end
