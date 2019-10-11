require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_number: "123456789")
  }
  
  let (:no_phone_num_hash) {
    {
      passenger: {
        name: "new passenger",
      },
    }
  }
  
  let (:no_name_hash) {
    {
      passenger: {
        phone_number: "123456789",
      },
    }
  }
  
  describe "index" do
    it "can get the index path" do 
      get "/passengers"
      must_respond_with :success
    end
    
    it "responds with success when there are many passengers saved" do
      3.times do
        Passenger.create name: "sample passenger", phone_number: "123456789"
      end
      
      expect(Passenger.count).must_equal 3
      
      
      get "/passengers"
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      expect(Passenger.count).must_equal 0
      
      get "/passengers"
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)
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
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_number: "123456789",
        },
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      created_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      
      expect(created_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(created_passenger.phone_number).must_equal passenger_hash[:passenger][:phone_number]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(created_passenger.id)
    end
    
    it "does not create a passenger if the form data violates Passenger validations" do  
      expect {
        post passengers_path, params: no_phone_num_hash
      }.wont_change "Passenger.count"
      
      expect {
        post passengers_path, params: no_name_hash
      }.wont_change "Passenger.count"
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      get edit_passenger_path(passenger.id)
      
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    before do
      Passenger.create name: "sample passenger", phone_number: "123456789"
      @existing_passenger = Passenger.first
    end
    
    it "can update an existing passenger with valid information accurately, and redirect" do
      expect(@existing_passenger).wont_be_nil
      
      update_hash = {
        passenger: {
          name: "Monica Geller",
          phone_number: "9103222610",
        },
      }
      
      expect {
        patch passenger_path(@existing_passenger.id), params: update_hash
      }.wont_change 'Passenger.count'
      
      updated_passenger = Passenger.find_by(id: @existing_passenger.id)
      
      expect(updated_passenger.name).must_equal "Monica Geller"
      expect(updated_passenger.phone_number).must_equal "9103222610"
      
      must_respond_with :redirect
    end
    
    it "does not update any passenger if given an invalid id, and responds with a 404" do
      update_hash = {
        passenger: {
          name: "Monica Geller",
          phone_number: "9103222610",
        },
      }
      
      expect {
        patch passenger_path(-1), params: update_hash
      }.wont_change "Passenger.count"
      
      must_respond_with :not_found
    end
    
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      expect {
        patch assign_rating_path(@existing_passenger.id), params: no_name_hash
      }.wont_change "Passenger.count"
      
      updated_passenger = Passenger.find_by(id: @existing_passenger.id)
      
      expect(updated_passenger.name).must_equal @existing_passenger[:name]
      expect(updated_passenger.phone_number).must_equal @existing_passenger[:phone_number]
      
      expect {
        patch assign_rating_path(@existing_passenger.id), params: no_phone_num_hash
      }.wont_change "Passenger.count"
      
      updated_passenger = Passenger.find_by(id: @existing_passenger.id)
      
      expect(updated_passenger.name).must_equal @existing_passenger[:name]
      expect(updated_passenger.phone_number).must_equal @existing_passenger[:phone_number]
    end
  end
  
  describe "destroy" do
    before do
      Passenger.create name: "sample passenger", phone_number: "123456789"
      @existing_passenger = Passenger.first
    end
    
    it "destroys the driver instance in db when driver exists and redirects" do
      expect(Passenger.count).must_be :>, 0
      
      expect {
        delete passenger_path(@existing_passenger.id)
      }.must_change 'Passenger.count', 1
      
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
    
    it "does not change the number of trips" do
      expect(Passenger.count).must_be :>, 0
      
      expect {
        delete passenger_path(@existing_passenger.id)
      }.wont_change 'Trip.count'
    end
    
    it "responds with not found when getting the edit page for a non-existing trip" do
      delete trip_path(-1)
      must_respond_with :not_found
    end
  end
end
