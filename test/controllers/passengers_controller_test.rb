require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_num: "333333333"
  }
  
  describe "index" do
    it "gives back a successful response when passenges saved" do
      get passengers_path
      must_respond_with :success
    end 
    
    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "will redirect for an invalid passenger" do
      get passenger_path(-1)
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    # add a before do to DRY code
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "sample passenger",
          phone_num: "333333333",
        },
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end     
  end 
  
  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      must_respond_with :redirect
    end
  end 
  
  describe "update" do
    before do
      @new_passenger = Passenger.create(name: "new passenger")
    end 
    
    it "can update an existing passenger" do
      existing_passenger = Passenger.first
      
      updated_passenger_form_data = {
        passenger: {
          name: "updated passenger",
          phone_num: "44444444"
        },
      }
      
      expect {
        patch passenger_path(existing_passenger.id), params: updated_passenger_form_data
      }.wont_change "Passenger.count"
      
      expect(Passenger.find_by(id: existing_passenger.id).name).must_equal "updated passenger"
      expect(Passenger.find_by(id: existing_passenger.id).phone_num).must_equal "44444444"
    end
    
    it "will redirect to the root page if given an invalid id" do
      get passenger_path(-1)
      must_respond_with :redirect
    end
    
    describe "destroy" do
      before do
        @new_passenger = Passenger.create(name: "new passenger")
      end
      
      it "can delete an existing passenger" do
        existing_passenger = Passenger.last
        
        expect {
          delete passenger_path(existing_passenger.id)
        }.must_change "Passenger.count", -1
      end
      
      it "will redirect to the root page if given an invalid id" do
        get passenger_path(-1)
        must_respond_with :redirect
      end
    end
  end
end 
