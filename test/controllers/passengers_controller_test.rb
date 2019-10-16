require "test_helper"


describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Dolly", phone_num: "360-931-1677"
  }
  describe "index" do
    it "can get the index path" do
      get passengers_path
      must_respond_with :success
    end
    
    describe "show" do
      it "can get a valid passenger" do
        get passengers_path(passenger.id)
        must_respond_with :success
      end
      
      it "will redirect for an invalid passenger" do
        get passengers_path(-1)
        must_respond_with :success
      end
    end
    
    describe "new" do
      it "can display the new passenger page" do
        get new_passenger_path
        must_respond_with :success
      end
    end
    
    describe "create" do
      it "can create a new passenger" do
        new_passenger_params = {
          passenger: {
            name: "Fido",
            phone_num: "xxx-xxx-xxxx",
          },
        }
        
        expect {
          post passengers_path, params: new_passenger_params
        }.must_change "Passenger.count", 1
        
        new_passenger = Passenger.find_by(name: new_passenger_params[:passenger][:name])
        expect(new_passenger.phone_num).must_equal new_passenger_params[:passenger][:phone_num]
        
        must_respond_with :redirect
        must_redirect_to passenger_path(new_passenger)
      end
    end
    
    describe "edit" do
      it "can show the edit page for passenger" do
        get edit_passenger_path(passenger)
        must_respond_with :success
      end
      
      it "redirects when given invalid passenger id" do
        
        get edit_passenger_path(-1)
        must_redirect_to passengers_path
      end
    end
    
    
    
    describe "update" do
      # Your tests go here
    end
    
    describe "destroy" do
      it "destroys the passenger instance in db when passenger exists, then redirects" do
        # Arrange
        count = Passenger.count
        new_passenger = Passenger.create name: "Spammy Spam", phone_num: "333-333-3333"
        
        expect(Passenger.count).must_equal (count + 1)
        
        expect{
          delete passenger_path(new_passenger.id)
        }.must_change "Passenger.count", 1
        must_respond_with :redirect
        must_redirect_to passengers_path
      end
      
      it "does not change the db when the passenger does not exist " do
        before_count = Passenger.count
        delete passenger_path(-1)
        after_count = Passenger.count
        
        expect(before_count).must_equal after_count
      end
    end
  end
end
