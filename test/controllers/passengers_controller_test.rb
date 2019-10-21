require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "Bob Ross", phone_num: "1234567891")
  }

  describe "index" do
    # Your tests go here

    it "gives back a successful response" do
      get passengers_path
      must_respond_with :success
    end
  end

  describe "show" do
    # Your tests go here
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      valid_passenger = passenger
      # Act
      get passenger_path(valid_passenger.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Act
      get passenger_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    # Your tests go here
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    # Your tests go here
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_hash = {
        passenger: {
          name: "John Doe",
          phone_num: "987654321",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 1

      must_redirect_to passenger_path(Passenger.find_by(name: "John Doe"))
    end

    it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
      passenger_hash = {
        passenger: {
          name: "",
          phone_num: "",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ "Passenger.count", 0

      assert_template :new
    end
  end

  describe "edit" do
    # Your tests go here
    it "responds with success when getting the edit page for an existing, valid passenger" do
      valid_passenger = passenger
      get edit_passenger_path(valid_passenger.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-1)
      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    # Your tests go here
    it "updates a passenger and redirects to passenger details page " do
      old_passenger = passenger
      updated_passenger = {
        passenger: {
          name: "Spongebob Squarepants",
          phone_num: "3456213450",
        },
      }

      expect {
        patch passenger_path(old_passenger.id), params: updated_passenger
      }.must_differ "Passenger.count", 0

      expect(Passenger.find_by(id: old_passenger.id).name).must_equal "Spongebob Squarepants"
      expect(Passenger.find_by(id: old_passenger.id).phone_num).must_equal "3456213450"
      must_redirect_to passenger_path(old_passenger.id)
    end

    it "does not update if given invalid id and gives back 404 error" do
      updated_passenger = {
        passenger: {
          name: "Spongebob Squarepants",
          phone_num: "3456213450",
        },
      }

      expect {
        patch passenger_path(-1), params: updated_passenger
      }.must_differ "Passenger.count", 0

      must_respond_with :not_found
    end

    it "does not update a passenger if the form data violates Passenger validations, and responds with a redirect" do
      old_passenger = passenger
      updated_passenger = {
        passenger: {
          name: "",
          phone_num: "",
        },
      }

      expect {
        patch passenger_path(old_passenger.id), params: updated_passenger
      }.must_differ "Passenger.count", 0

      must_redirect_to passenger_path(old_passenger.id)
    end
  end

  describe "destroy" do
    # Your tests go here
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      old_passenger = passenger
      expect {
        delete passenger_path(old_passenger.id)
      }.must_differ "Passenger.count", -1
      must_redirect_to passengers_path
    end

    it "does not change the db when the passenger does not exist, then responds with " do
      expect {
        delete passenger_path(-1)
      }.must_differ "Passenger.count", 0
      must_redirect_to passengers_path
    end

    it "redirects to root path and deletes nothing the passenger has already been deleted" do
      old_passenger = passenger
      Passenger.destroy_all

      expect {
        delete passenger_path(passenger.id)
      }.must_differ "Passenger.count", 0

      must_redirect_to passengers_path
    end
  end
end
