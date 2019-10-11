require "test_helper"

describe TripsController do
  # let (:trip) {
  #   Trip.create driver_id: 10, passenger_id: 7, date: Date.current, rating: 3, cost: 0.00
  # }
  # let (:passenger) {
  #   Passenger.create name: "Emmanuelle Breitenberg", phone_num: "(707) 341-7157 x98757"
  # }
  # let (:driver) {
  #   Driver.create name: "Dr. Kenton Berge", vin: "SXMMLZX8XGDN7L7TL"
  # }
  
  describe "index" do
    it "can get the index path" do
      # Act
      get trips_path
      
      # Assert
      must_respond_with :success# Your tests go here
    end
    
    it "can get the root path" do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
    
  end
  
  
  
  describe "show" do
    before do 
      @passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
      @driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, cost: 10.00)
    end
    
    it "can get a valid trip" do
      @trip.save
      get trip_path(@trip.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid trip" do
      # Act
      get trip_path(-1)
      must_respond_with :not_found
    end
  end
  
  
  describe "create" do
    before do 
      @passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
      @driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
    end
    it "can create a new trip" do
      
      # trip_hash = {
      #   trip: {
      #     driver_id: @driver.id, 
      #     passenger_id: @passenger.id, 
      #     date: Date.current, 
      #     rating: nil, 
      #     cost: 0.00
      #   }
      # }
      p @passenger.id
      # Act-Assert
      expect {
        post trips_path, params: trip_hash
      }.must_change "Trip.count", 1
      
      new_trip = Trip.find_by(name: trip_hash[:trip][:name])
      expect(new_trip.driver_id).must_equal trip_hash[:trip][:driver_id]
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]
      expect(new_trip.date).must_equal trip_hash[:trip][:date]
      expect(new_trip.rating).must_equal trip_hash[:trip][:rating]
      expect(new_trip.cost).must_equal trip_hash[:trip][:cost]
      
      must_respond_with :redirect
    end
  end
  
  
  describe "edit" do
    before do 
      @passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
      @driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
      @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, cost: 10.00)
    end
    
    it "can get the edit page for an existing trip" do
      
      get edit_trip_path(@trip.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant trip" do
      
      get edit_trip_path(8923749234)
      
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    before do 
      @new_passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
      @new_driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
      @new_trip = Trip.create(driver_id: @new_driver.id, passenger_id: @new_passenger.id, date: Date.today, rating:nil, cost: 10.00)
    end
    
    it "can update an existing trip" do
      updated_trip_form_data = {
        trip: {
          driver_id: @new_driver.id, 
          passenger_id: @new_passenger.id, 
          date: Date.today, 
          rating: 3, 
          cost: 10.00
        }
      }
      
      expect {  
        patch trip_path(@new_trip.id), params: updated_trip_form_data
      }.wont_change "Trip.count"
      
      @new_trip.reload
      
      expect(@new_trip.rating).must_equal 3
    end
    
    it "will redirect to the root page if given an invalid id" do
      updated_trip_form_data = {
        trip: {
          driver_id: @new_driver.id, 
          passenger_id: @new_passenger.id, 
          date: Date.today, 
          rating: 3, 
          cost: 10.00
        }
      }
      
      expect {
        patch trip_path(2348734), params: updated_trip_form_data
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
  end
  
  describe "destroy" do
    before do 
      @passenger = Passenger.create(name: "Emmanlle Breiterg", phone_num: "(707) 341-7157")
      @driver = Driver.create(name: "Dr. Ken Berge", vin: "SXMMLZX8XGDN7L7TM", available: true)
      @trip_to_be_destroyed = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, cost: 10.00)
    end
    
    it "can destroy a trip" do
      
      trip_to_be_destroyed_id = @trip_to_be_destroyed.id
      
      expect {
        delete trip_path(trip_to_be_destroyed_id)
      }.must_differ 'Trip.count', -1        
      # get task_path(@task_to_be_destroyed.id)
      # must_respond_with :redirect
      must_redirect_to trips_path
    end 
  end
end
