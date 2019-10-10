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

      must_redirect_to passenger_path
    end 

    it "will respond with a redirect when attempting to edit a non-existing passenger" do
      #Act
      get edit_passenger_path(id: 5000)

      #Assert
      must_redirect_to passengers_path
    end 
  end

  describe "update" do
    it "can update an existing passenger" do 



    passenger_hash = {
      passenger: {
        name: "Victoria",
        phone_num: "456-654-9076"
      }
    }

      # Act-Assert
      # task_hash info is being sent to server and stored in params via the patch request
      patch passenger_path(id: passenger.id), params: passenger_hash

      # finding it in the database and assigning it to new variable
      updated_passenger = Passenger.find_by(id: passenger.id)

      expect(updated_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
    end
  end

  describe "destroy" do
    it "will delete a task from the database" do

      passenger

      expect {
        delete passenger_path(id: passenger.id) 
      }.must_differ 'Passenger.count', -1
    end
  end
end
