require "test_helper"

describe PassengersController do
  before do
    @passenger = Passenger.create(name: "Hermione Granger", phone_num: "904-000-000")
  end
  
  describe "index" do
    it "can get the list of passengers and repond with success" do
      get passengers_path 
      
      must_respond_with :success
    end
    
    it "responds with success when there is no passengers saved" do
      expect (Passenger.count).must_equal 1
      
      Passenger.destroy_all
      expect (Passenger.count).must_equal 0
      
      get passengers_path 
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      existing_passenger_id = Passenger.first.id

      get passenger_path(existing_passenger_id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)

      must_respond_with :not_found
    end
  end
  
  describe "new" do
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "creates new passenger on database for valid input and redirects" do
      Passenger.destroy_all
      expect(Passenger.count).must_equal 0

      passenger_info = {
          passenger: {
            name: "Harry Potter",
            phone_num: "4225-000-000"
          }
      }
      
      expect { post passengers_path, params: passenger_info}.must_differ "Passenger.count", 1
      new_passenger = Passenger.first
      expect (new_passenger.name).must_equal passenger_info[:passenger][:name]
      expect (new_passenger.phone_num).must_equal passenger_info[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "redirects if input is invalid and does not create a passenger" do
      passenger_hashes = [
        {
          passenger: {
            name: "",
            phone_num: ""
          },
        },
        {
          passenger: {
            name: "      ",
            phone_num: "     "
          },
        },
        {
          passenger: {
            name: nil,
            phone_num: nil
          }
        },
        {
          passenger: {
          }
        }
      ]

      passenger_hashes.each do |passenger_info|
        expect {
          post passengers_path, params: passenger_info
        }.must_differ "Passenger.count", 0
        must_respond_with :redirect
        must_redirect_to new_passenger_path
      end
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      passenger_id = Passenger.first.id

      get edit_passenger_path(passenger_id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-1)

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
