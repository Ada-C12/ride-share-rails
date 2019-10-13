require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "Sue Perkins", phone_number: "917-223-1234")
  }
  
  describe "index" do
    it "responds with success when there are many passengers saved" do
      
      get passengers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      
      Passenger.destroy_all
      expect (Passenger.count).must_equal 0
      
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when provided with a valid passenger ID" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "responds with redirect when provided with an invalid passenger ID" do 
      get passenger_path(0)
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "successfully loads the new passenger form" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new passenger when provided with valid information and redirect to passenger show page" do
      
      Passenger.destroy_all
      expect (Passenger.count).must_equal 0
      
      new_passenger = {
        passenger: {
          name: "Lloyd Dobler",
          phone_number: "2061234567",
        }
      }
      
      expect {
        post passengers_path, params: new_passenger
      }.must_differ "Passenger.count", 1
      created_passenger = Passenger.first 
      expect (created_passenger.name).must_equal new_passenger[:passenger][:name]
      expect (created_passenger.phone_number).must_equal new_passenger[:passenger][:phone_number]
      
      must_redirect_to passenger_path(created_passenger.id)
      
    end
    
    it "does not create a passenger if input is invalid" do
      
      invalid_passengers = [
        {
          passenger: {
            name: nil, 
            phone_number: "206-555-1234"
          },
        },
        { 
          passenger: {
            name: "Quincy Jones", 
            phone_number: nil  
          },
        },
        {
          passenger: {
            name: "",
            phone_number: "206-555-1234"
          },
        },
        {
          passenger: {
            name: "Quincy Jones",
            phone_number: ""
          }
        },
        {
          passenger: {
            name: "       ",
            phone_number: "206-555-1234"
          },
        },
        {
          passenger: {
            name: "Quincy Jones",
            phone_number: "      "
          }
        }
      ]
      
      invalid_passengers.each do |passenger|
        expect {
          post passengers_path, params: passenger}.must_differ "Passenger.count", 0
          must_respond_with :success
          
        end
      end
    end
    
    describe "edit" do
      it "can successfully the edit page when provided with a valid id" do 
        passenger_id = Passenger.last.id
        
        get edit_passenger_path(passenger_id)
        
        must_respond_with :success
      end
      
      it "redirects to passengers page when provided with an invalid id" do
        get edit_passenger_path(-5)
        must_respond_with :redirect
        must_redirect_to passengers_path
        
      end
      
    end
    
    describe "update" do
      # Your tests go here
    end
    
    describe "destroy" do
      # Your tests go here
    end
  end
  