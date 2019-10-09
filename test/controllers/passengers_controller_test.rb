require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create name: "A Passenger Name", phone_num: "555-555-5555"}

  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

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
      expect(new_passenger.phone_num).must_equal task_hash[:task][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      # skip
      get edit_passenger_path(passenger.id)

      # Assert
      must_respond_with :success
      
    end

    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      # Your code here
      invalid_id = -500
      
      get edit_passenger_path(invalid_id)

      must_respond_with :redirect

      must_redirect_to passengers_path
    end
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
