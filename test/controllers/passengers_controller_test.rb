require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "Annika", phone_num: "334-213-2473"
  }
  describe "index" do
    it "gives back a successful response" do
      #Act
      get passengers_path

      #Assert
      must_respond_with :success
    end 

    it "can get the root path" do
      #Act
      get root_path

      #Assert
      must_respond_with :success
    end 
  end

  describe "show" do
    it "shows passenger details" do
      get passenger_path(passenger.id)

      must_respond_with :success
    end 

    it "will respond with an error for an invalid task" do
      # Act
      get passenger_path(-1)

      # Assert
      must_respond_with :missing
    end
  end

  describe "new" do
    it "will get the new passenger page" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "will create a new instance of passenger" do
      # Arrange 
      passenger_hash = {
        passenger: {
          name: "Victoria",
          phone_num: "456-654-9076"
        }
      }

      # Act
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1


      # Act
      must_redirect_to passengers_path
    end 
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      #Act
      get edit_passenger_path(passenger.id)

      must_respond_with :success
    end 
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
