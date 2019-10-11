require "test_helper"

describe PassengersController do
  let (:example_passenger)  {             
    Passenger.create(name: "Ursula Le Guin", phone_num: "320-444-5555") 
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do 
      ursula = example_passenger
      madeleine = Passenger.create(name: "Madeleine L'Engle", phone_num: "320-444-5555") 
      get passengers_path
      must_respond_with :success
    end
    
    it "responds with success when there are no passengers saved" do
      get passengers_path
      must_respond_with :success
    end 
  end 
  
  describe "show" do
    it "responds with a success when id given exists" do 
      get passenger_path(example_passenger.id)
      must_respond_with :success
    end
    
    it "responds with a not_found when id given doesn't exist" do 
      get passenger_path(57204)
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
    
    it "creates a new passenger successfully with valid data, and redirects to the passengers page" do 
      passenger_hash = {
        passenger: {
          name: "Sally Rooney",
          phone_num: "320-333-4444" 
        }
      }
      expect { post passengers_path, params: passenger_hash}.must_change "Passenger.count", 1  
      must_redirect_to passengers_path

      sally = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(sally.name).must_equal passenger_hash[:passenger][:name]
      expect(sally.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end
      
    it "does not create a passenger from invalid form data, and responds with a redirect" do
      bad_pass = { passenger: { name: nil, phone_num: nil}}
      
      expect { post passengers_path, params: bad_pass}.wont_change "Passenger.count"
      must_respond_with :success
    end 
  end 
    
  describe "edit" do
    it "can get the edit page for an existing passenger" do 
      get edit_passenger_path(example_passenger.id)
      must_respond_with :success
    end
    
    it "redirects when asked to edit an invalid passenger" do
      get edit_passenger_path(-4938)
      must_respond_with :not_found
    end
  end  
  
  describe "update" do 
    before do 
      @ursula = example_passenger
      @updated_passenger_data = {
        passenger: {
          name: "Updated name",
          phone_num: "999-999-9999"
        } 
      }
    end 

    it "updates an existing passenger and redirects to passengers list" do 
      expect { patch passenger_path(@ursula.id), params: @updated_passenger_data }.wont_change "Passenger.count"
      
      patch passenger_path(@ursula.id), params: @updated_passenger_data
      must_respond_with :redirect
      
      expect _(Passenger.find(@ursula.id).name).must_equal "Updated name"
      expect _(Passenger.find(@ursula.id).phone_num).must_equal "999-999-9999"
    end 

    it "does not update any passenger if given an invalid ID, and responds with not found" do  
      expect { 
        patch passenger_path(-3948), params: @updated_passenger_data
      }.wont_change "Passenger.count"
      must_respond_with :not_found 
    end 
  end 

  describe "destroy" do
    it "can destroy a passenger" do 
      ursula = example_passenger
      expect { delete passenger_path(ursula.id) }.must_change 'Passenger.count', -1
      must_respond_with :redirect
      must_redirect_to passengers_path

      get passenger_path(ursula.id)
      must_respond_with :missing
    end 

    it "does not change the db when selected passenger doesn't exist" do 
      expect { delete passenger_path (-2948)}.wont_change "Passenger.count"
      must_respond_with :not_found
    end
  end 
end
