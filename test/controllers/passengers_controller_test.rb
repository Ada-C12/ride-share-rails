require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Johnny Appleseed", phone_num: "541-433-7865"
  }
  
  describe "index" do
    
    it "gives back a successful response" do
      
      get passengers_path
      must_respond_with :success
      
    end
    
  end
  
  describe "show" do
    
    it 'responds with a success when id given exists' do
      
      valid_passenger = Passenger.create(name: "Ada Lovelace", phone_num: "503-569-9987")
      
      get passenger_path(valid_passenger.id)
      must_respond_with :success
      
    end
    
    it 'responds with a not_found when id given does not exist' do
      
      get passenger_path("5000")
      must_respond_with :not_found
      
    end
    
  end
  
  describe "new" do
    it "gives back a successful response" do
      
      get new_passenger_path
      must_respond_with :success
      
    end
  end
  
  describe "create" do
    
    it 'creates a new passenger successfully with valid data, and redirects the user to the passenger page' do
      
      passenger_hash = {
        passenger: {
          name: "Ada Lovelace",
          phone_num: "503-569-9987"
        }
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1
      
      must_redirect_to passengers_path
    end
    
  end
  
  describe "edit" do
    it "can get the edit page for an existing task" do
      #skip
      # Your code here
      get edit_passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant task" do
      #skip
      # Your code here
      get edit_passenger_path(9999)
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    before do
      @valid_passenger = Passenger.create(name: "Ada Lovelace", phone_num: "503-569-9987")
    end
    
    it "updates an existing passenger successfully and redirects to home" do
      
      existing_passenger = Passenger.first
      
      updated_passenger_hash = {
        passenger: {
          name: "Bill Gates",
          phone_num: "541-569-9987"
        }
      }
      
      expect {
        patch passenger_path(existing_passenger.id), params: updated_passenger_hash
      }.wont_change 'Passenger.count'
      
      # Assert
      expect( Passenger.find_by(id: existing_passenger.id).name ).must_equal "Bill Gates"
      expect( Passenger.find_by(id: existing_passenger.id).phone_num ).must_equal "541-569-9987"
    end
  end
  
  describe "destroy" do
    
    it 'deletes a new passenger successfully with valid data, and redirects the user to the passengers page' do
      
      passenger_hash = {
        passenger: {
          name: "Ada Lovelace",
          phone_num: "503-569-9987"
        }
      }
      
      post passengers_path, params: passenger_hash
      identifier = Passenger.find_by(name: "Ada Lovelace")
      
      expect {
        delete passenger_path(identifier.id)
      }.must_differ 'Passenger.count', -1
      
      must_redirect_to passengers_path
    end
  end
end
