require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do

      new_passenger = Passenger.create name: "Random name", phone_num: "206-123-3333"

      get passengers_path

      must_respond_with :success
    end

    it "responds with success when there are no passengers saved" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @passenger = Passenger.create name: "Random name", phone_num: "206-123-3333"
    end

    it "responds with success when showing an existing valid passenger" do
      get passenger_path(@passenger.id)

      must_respond_with :success
    end

    it "responds with 404 with an invalid passenger id" do
      invalid_id = -1

      get passenger_path(invalid_id)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do

      passenger_hash = {
        passenger: {
          name: "Bob's Burgers",
          phone_num: "XXX-XXX-XXXX"
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

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      passenger_hash = {
        passenger: {
          phone_num: "XXX-XXX-XXX"
        }
      }

      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :success   
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do

      @passenger = Passenger.create name: "Random name", phone_num: "XXX-XXX-XXXX"

      get edit_passenger_path(@passenger.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do

      get edit_passenger_path(-1)

      must_respond_with :redirect
      must_redirect_to passengers_path
    end
  end

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do

      existing_passenger = Passenger.create name: "Harry Potter", phone_num: "aaa-aaa-aaaa"

      updated_passenger_hash = {
        passenger: {
          name: "Ron Weasley",
          phone_num: "zzz-zzz-zzzz"
        },
      }

      expect {
        patch passenger_path(existing_passenger.id), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      updated_passenger = Passenger.find_by(id: existing_passenger.id)

      expect(updated_passenger.name).must_equal updated_passenger_hash[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal updated_passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(updated_passenger)

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do

      updated_passenger_hash = {
        passenger: {
          name: "Ron Weasley",
          phone_num: "zzz-zzz-zzzz"
        },
      }

      invalid_passenger_id = -1

      patch passenger_path(invalid_passenger_id), params: updated_passenger_hash

      must_respond_with :not_found


    end

    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      existing_passenger = Passenger.create name: "Harry Potter", phone_num: "XXX-XXX-XXXX"

      updated_passenger_hash = {
        passenger: {
          name: "Ron Weasley"
        }
      }

      expect {
        patch passenger_path(existing_passenger.id), params: updated_passenger_hash
      }.wont_change "Passenger.count"

      passenger_id = Passenger.find_by(id: existing_passenger.id)

      must_respond_with :redirect
      must_redirect_to passenger_path(passenger_id)
    end
  end

  describe "destroy" do

  end
end
