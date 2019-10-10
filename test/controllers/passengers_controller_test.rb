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
    
    it "render the form if input is invalid and does not create a passenger" do
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
        }
      ]
      
      passenger_hashes.each do |passenger_info|
        expect {
          post passengers_path, params: passenger_info
        }.must_differ "Passenger.count", 0
        must_respond_with :success
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
    before do
      @updated_info = {
        passenger: {
          name: "Tofu Le",
          phone_num: "1234567890"
        }
      }
    end
    
    it "can update information of an existing passenger with valid information and redirect" do
      existing_passenger = Passenger.find_by(id: @passenger.id)
      
      expect {
        patch passenger_path(existing_passenger.id), params: @updated_info
      }.must_differ "Passenger.count", 0
      
      updated_passenger = Passenger.find_by(id: @passenger.id)
      expect(updated_passenger.name).must_equal @updated_info[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal @updated_info[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(@passenger.id)
    end
    
    it "cannot update information if given a nonexisting passenger id and respond with a 404" do
      expect {
        patch passenger_path(-1), params: @updated_info
      }.must_differ "Passenger.count", 0
      must_respond_with :not_found
    end
    
    it "does not create a passenger if the form data violates passenger validations, and responds with a render" do
      passenger_id = @passenger.id
      updated_passenger_data = {
        passenger: {
          name: "", 
          phone_num: ""
        },
      }

      expect {
        patch passenger_path(passenger_id), params: updated_passenger_data
      }.must_differ "Passenger.count", 0

      must_respond_with :success
    end
  end
  
  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      existing_passenger = Passenger.first
      existing_passenger_id = existing_passenger.id
      expect (Passenger.count).must_equal 1
      
      expect {
        delete passenger_path(existing_passenger_id)
      }.must_differ "Passenger.count", -1
      
      assert_nil (Passenger.find_by(id: existing_passenger_id))
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
    
    it "does not change the db when the passenger does not exist, then responds with redirect" do
      invalid_id = -1
      expect (Passenger.count).must_equal 1
      assert_nil (Passenger.find_by(id: invalid_id))
      
      expect { delete passenger_path(invalid_id) }.must_differ "Passenger.count", 0
      
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end
end
