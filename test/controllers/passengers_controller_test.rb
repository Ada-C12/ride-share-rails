require "test_helper"

describe PassengersController do

  before do
    @passenger = Passenger.create(name: "Sue Perkins", phone_number: "917-223-1234")
  end
  
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
      get passenger_path(@passenger.id)
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
      }
      .must_differ "Passenger.count", 1
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
          post passengers_path, params: passenger
        }
        .must_differ "Passenger.count", 0
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
    
    before do
      @to_update = {
        passenger: {
          name: "Thursday Next",
          phone_number: "4315543215"
        }
      }
    end
    
    it "can update existing passenger information when provided with a valid id and redirect to passenger show page" do
      
      existing_passenger = Passenger.find_by(id: @passenger.id)
      
      expect {
        patch passenger_path(existing_passenger.id), params: @to_update
      }.must_differ "Passenger.count", 0
      
      updated_passenger = Passenger.find_by(id: @passenger.id)
      expect(updated_passenger.name).must_equal @to_update[:passenger][:name]
      expect(updated_passenger.phone_number).must_equal @to_update[:passenger][:phone_number]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end

    it "if given invalid id, will not update information and will redirect to passengers list" do
      expect {
        patch passenger_path(0), params: @to_update
      }.must_differ "Passenger.count", 0
      must_redirect_to passengers_path
    end
  end
  
  describe "destroy" do
    # Your tests go here
  end
  
end