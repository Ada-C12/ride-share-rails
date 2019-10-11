require "test_helper"

describe PassengersController do
  let(:passenger){
    Passenger.create name: "test name", phone_num: "1111111"
  }
  describe "index" do
    it "gives back a successful response" do
      # Arrange
      # ... Nothing right now!
      
      # Act
      # Send a specific request... a GET request to the path "/books"
      get passengers_path
      must_respond_with :success
    end
  end
    
  #   it "gives back a 404 if there are no books available" do
  #     get passengers_path
  #   end
  # end
  
  describe "show" do
    it 'responds with a success when id given exists' do
      valid_passenger = Passenger.create(name: "Valid Passenger", phone_num: "1111111")
      
      get passenger_path(valid_passenger.id)
      
      must_respond_with :success
      
    end
    
    it 'responds with a not_found when id given does not exist' do
      get passenger_path("500")
      
      must_respond_with :not_found
    end
    
  end


  describe "new" do
    it "responds with success" do
      # Act
      get new_passenger_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "1111111"
        }
      }

      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      # Assert
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])

      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passengers_path

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Passenger validations
      passenger_hash = {
        passenger: {
          name: "",
          phone_num: "1111111"
        }
      }

      passenger_hash_2 = {
        passenger: {
          name: "new passenger",
          phone_num: ""
        }
      }

      passenger_hash_3 = {
        passenger: {
          name: "",
          vin: ""
        }
      }


      # Act-Assert
      # Ensure that there is no change in Passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"

      expect {
        post passengers_path, params: passenger_hash_2
      }.wont_change "Passenger.count"

      expect {
        post passengers_path, params: passenger_hash_3
      }.wont_change "Passenger.count"

      # Assert
      # Check that the controller redirects
      expect :new

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      

      # Act
      get edit_passenger_path(passenger.id)

      # Assert
      must_respond_with :success

    end

    it "responds with not found when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger

      # Act
      get edit_passenger_path(-1)

      # Assert
      must_respond_with :not_found
      

    end
  end

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
  
      passenger_hash = {
        passenger: {
          name: "updated passenger name",
          phone_num: "1111111",
          id: passenger.id
        }
      }
      
      expect {
        patch passenger_path(passenger.id), params: passenger_hash
      }.wont_change "Passenger.count"

      passenger.reload
     
      expect(passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_redirect_to passengers_path

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do

      passenger_hash = {
        passenger: {
          name: "updated driver name",
          phone_num: "1111111",
        }
      }

      expect {
        patch passenger_path(-1), params: passenger_hash
      }.wont_change "Passenger.count"

      must_respond_with :not_found

    end

    it "does not update a passenger if the form data violates Passenger validations, and responds with a render" do

      passenger_hash = {
        passenger: {
          name: "",
          phone_num: "1111111",
          id: passenger.id
        }
      }

      passenger_hash_2 = {
        passenger: {
          name: "new passenger",
          phone_num: "",
          id: passenger.id
        }
      }

      passenger_hash_3 = {
        passenger: {
          name: "",
          phone_num: "",
          id: passenger.id
        }
      }

      expect {
        patch passenger_path(passenger.id), params: passenger_hash
      }.wont_change "Passenger.count"

      expect {
        patch passenger_path(passenger.id), params: passenger_hash_2
      }.wont_change "Passenger.count"

      expect {
        patch passenger_path(passenger.id), params: passenger_hash_3
      }.wont_change "Passenger.count"

      expect :edit


    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      
      passenger = Passenger.create(name: "test passenger", phone_num: "9999999")

      expect{
        delete passenger_path(passenger.id)
      }.must_differ 'Passenger.count', -1
      
      must_redirect_to passengers_path

    end

    it "does not change the db when the passenger does not exist, then responds with " do
     
      expect{
        delete passenger_path(-1)
      }.wont_change "Passenger.count"

       must_respond_with :not_found

    end
  end

end