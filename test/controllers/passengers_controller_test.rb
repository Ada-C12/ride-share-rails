require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_number: "123456789"
  }
  
  describe "index" do
    it "can get the index path" do 
      get "/passengers"
      must_respond_with :success
    end
    
    it "responds with success when there are many drivers saved" do
      3.times do
        Passenger.create name: "sample passenger", phone_number: "123456789"
      end
      
      expect(Passenger.count).must_equal 3
      
      get "/passengers"
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers saved" do
      expect(Passenger.count).must_equal 0
      
      get "/passengers"
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      get passenger_path(passenger.id)
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
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
      passenger_hash = {
        passenger: {
          name: "new passenger",
        },
      }
      
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"
      
      # result = post passengers_path, params: passenger_hash
      
      # puts "result.errors.any?"
      # puts result
      
      # expect(result.errors.any?).must_be_true
    end
  end
  
  
  # describe "edit" do
  #   it "can get the edit page for an existing passenger" do
  #     get passenger_path(passenger.id)
  
  #     # Assert
  #     must_respond_with :success
  #   end
  
  #   it "will respond with redirect when attempting to edit a nonexistant passenger" do
  #     patch passenger_path(-1)
  
  #     # Assert
  #     must_respond_with :redirect 
  #   end
  # end
  
  # describe "update" do
  #   before do
  #     @new_passenger = Passenger.create(name: "new passenger")
  #   end
  
  #   it "can update an existing passenger" do
  #     # existing_passenger = passenger.first
  #     updated_passenger_form_data = {
  #       passenger: {
  #         name: "Monica Geller",
  #         phone_number: "9103222610",
  #       }
  #     }
  #     expect {
  #       patch passenger_path(@new_passenger.id), params: updated_passenger_form_data
  #     }.wont_change 'Passenger.count'
  
  #     expect( Passenger.find_by(id: @new_passenger.id).name ).must_equal "Monica Geller"
  #   end
  # end
  
  # it "will redirect to the root page if invalid id is given" do
  #   invalid_id = -1
  #   updated_passenger_form_data = {
  #     passenger: {
  #       name: "Monica Geller",
  #       phone_number: "9103222610",
  #     }
  #   }
  #   patch passenger_path(invalid_id), params: updated_passenger_form_data
  
  #   # Assert
  #   must_respond_with :redirect
  #   must_redirect_to passenger_path
  
  # end
  
  # describe "destroy" do
  #   it "deletes a passenger if given a valid id" do
  #     valid_passenger = Passenger.first
  
  #     expect {
  #       delete passenger_path(valid_passenger.id)
  #     }.must_change 'Passenger.count', 1
  
  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  #   end
  
  #   it "will return not found if invalid id is given to delete" do
  #     invalid_id = -1
  #     # Act
  #     delete passenger_path(invalid_id)
  
  #     # Assert
  #     must_respond_with :not_found
  #   end
  # end
end
