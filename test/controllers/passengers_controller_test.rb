require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "sample passenger", phone_number: "123456789"
  }
  
  
  describe "index" do
    it "can get the index path" do 
      # Act
      get "/passengers"
      
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get a valid passenger" do
      # Act
      get passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid passenger" do
      # Act
      get passenger_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end
  
  describe "new" do
    it "can get the new passenger page" do
      
      # Act
      get new_passenger_path
      
      # Assert
      must_respond_with :success
    end
  end
  
  #   # describe "create" do
  #   #   it "can create a new passenger" do
  
  #   #     # Arrange
  #   #     passenger_hash = {
  #   #       passenger: {
  #   #         name: "new passenger",
  #   #         phone_number: "123456789",
  #   #       },
  #   #     }
  
  #   #     # Act-Assert
  #   #     expect {
  #   #       post passengers_path, params: passenger_hash
  #   #     }.must_change "Passenger.count", 1
  
  #   #     new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
  #   #     expect(new_passenger.phone_number).must_equal passenger_hash[:passenger][:phone_number]
  
  #   #     must_respond_with :redirect
  #   #     must_redirect_to passenger_path(new_passenger.id)
  #   #   end
  #   # end
  
  
  #   describe "edit" do
  #     it "can get the edit page for an existing passenger" do
  #       get passenger_path(passenger.id)
  
  #       # Assert
  #       must_respond_with :success
  #     end
  
  #     it "will respond with redirect when attempting to edit a nonexistant passenger" do
  #       patch passenger_path(-1)
  
  #       # Assert
  #       must_respond_with :redirect 
  #     end
  #   end
  
  #   describe "update" do
  #     before do
  #       @new_passenger = Passenger.create(name: "new passenger")
  #     end
  
  #     it "can update an existing passenger" do
  #       # existing_passenger = passenger.first
  #       updated_passenger_form_data = {
  #         passenger: {
  #           name: "Monica Geller",
  #           phone_number: "9103222610",
  #         }
  #       }
  #       expect {
  #         patch passenger_path(@new_passenger.id), params: updated_passenger_form_data
  #       }.wont_change 'Passenger.count'
  
  #       expect( Passenger.find_by(id: @new_passenger.id).name ).must_equal "Monica Geller"
  #     end
  #   end
  
  #   it "will redirect to the root page if invalid id is given" do
  #     invalid_id = -1
  #     updated_passenger_form_data = {
  #       passenger: {
  #         name: "Monica Geller",
  #         phone_number: "9103222610",
  #       }
  #     }
  #     patch passenger_path(invalid_id), params: updated_passenger_form_data
  
  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to passenger_path
  
  #   end
  
  #   describe "destroy" do
  #     it "deletes a passenger if given a valid id" do
  #       valid_passenger = Passenger.first
  
  #       expect {
  #         delete passenger_path(valid_passenger.id)
  #       }.must_change 'Passenger.count', 1
  
  #       # Assert
  #       must_respond_with :redirect
  #       must_redirect_to root_path
  #     end
  
  #     it "will return not found if invalid id is given to delete" do
  #       invalid_id = -1
  #       # Act
  #       delete passenger_path(invalid_id)
  
  #       # Assert
  #       must_respond_with :not_found
  #     end
  #   end
end
