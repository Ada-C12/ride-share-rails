require "test_helper"

describe PassengersController do
  # creates a placeholder instance of Passenger that will be used in trip records in place of deleted Passengers. 
  before do
    deleted_passenger = Passenger.new(id: 0, name: "previously deleted", phone_num: "000-000-0000")
    deleted_passenger.save
  end
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      test_passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      other_test_passenger = Passenger.create(name: "muahaha", phone_num: "756658494")
      get passengers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    before do
      @test_passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
    end
    it "responds with success when showing an existing valid passenger" do
      get passenger_path(@test_passenger.id) 
      must_respond_with :success
    end
    it "responds with 404 with an invalid passenger id" do
      get passenger_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "new" do
    it "can get the new passenger path" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do    
    it "can can create a new instance of passenger " do
      passenger_hash = {
        passenger: {
          name: "test_passenger",
          phone_num: "1-888-975-5309",
        },
      }
      expect { post passengers_path, params: passenger_hash }.must_change "Passenger.count", 1 
    end
  end
  
  describe "edit" do
    before do
      @test_passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
    end
    
    it "reponds with success when editing the profile of a valid passenger" do
      get edit_passenger_path(@test_passenger.id)
      must_respond_with :success
    end
    
    it "responds with redirect when editing the profile of an invalid passenger" do 
      get edit_passenger_path(-9)
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    it "can update an existing passenger's profile with accurate information" do
      test_passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      id = test_passenger.id
      updated_phone_num = "333-8888"
      updated_name = "Everyone Is"
      
      found_test_passenger = Passenger.find_by(id: id)
      found_test_passenger.phone_num = updated_phone_num
      found_test_passenger.name = updated_name
      found_test_passenger.save
      
      expect(Passenger.find_by(id: id).phone_num).must_equal updated_phone_num
      
      expect(Passenger.find_by(id: id).name).must_equal updated_name
      
    end
  end
  
  describe "destroy" do
    it "destroys passenger and redirects" do
      other_passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      passenger = Passenger.create(name: "test_passenger", phone_num: "4385902")
      passenger_id = Passenger.first.id
      expect { delete passenger_path(passenger_id) }.must_change "Passenger.count", -1
      must_respond_with :redirect
    end
    
    it "will respond with 404 if attempting to delete invalid passenger and trip count will be unaffected" do
      expect { delete passenger_path(-9) }.wont_change "Passenger.count"
      must_respond_with :not_found
    end
  end
end