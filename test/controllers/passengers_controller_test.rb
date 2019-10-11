require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "A Passenger Name", phone_num: "555-555-5555")}

  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path
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
      must_respond_with :not_found
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

  describe "create" do
    it "can create a new passenger" do

      # Arrange
      passenger_hash = {
        passenger: {
          name: "A new passenger",
          phone_num: "999-999-9999"
        },
      }

      # Act-Assert
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
    it "responds with success" do
      # skip
      get edit_passenger_path(passenger.id)

      # Assert
      must_respond_with :success
      
    end
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      # Your code here
      invalid_id = -500

      get edit_passenger_path(invalid_id)
      
      must_redirect_to passenger_path
    end
  end

  describe "update" do
    # Your tests go here
    it "updates an existing passengers successfully and reloads page" do
      input_passenger = Passenger.create(name: "Input Passenger", phone_num: "1111111111")
      input_updates = {passenger: {name: "Updated Passenger", phone_num: "2222222222"}}

      patch passenger_path(input_passenger), params: input_updates

      input_passenger.reload
      expect(input_passenger.name).must_equal "Updated Passenger"
    end

    it "does not update a passenger if the form violates Passenger validations, and responds with redirect" do
      old_passenger = passenger
      updated_passenger = {
        passenger: {
          name: "",
          phone_num: ""
        },
      }

      expect {
        patch passenger_path(old_passenger.id), params: updated_passenger
      }.must_differ "Passenger.count", 0

      must_redirect_to edit_passenger_path(old_passenger.id)
    end
  end

  describe "destroy" do
    # Your tests go here
    it "successfully deletes an existing Passenger and then redirects to list of passengers at passengers index" do
      Passenger.create(name: "Input Passenger", phone_num: "1111111111")
      existing_passenger_id = Passenger.find_by(name: "Input Passenger").id

      expect {
        delete passenger_path( existing_passenger_id )
      }.must_differ "Passenger.count", -1

      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with 404" do
      passenger.save

      expect {
        delete passenger_path(-1)
    }.must_differ "Passenger.count", 0
    
    must_respond_with :redirect
    end
  end
end
