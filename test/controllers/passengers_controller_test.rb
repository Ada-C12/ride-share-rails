require "test_helper"

describe PassengersController do
  describe "index" do
    it "gives back a successful response" do
      # Arrange
      # ... Nothing right now!
      
      # Act
      # Send a specific request... a GET request to the path "/books"
      get books_path
      must_respond_with :success
    end
    
    it "gives back a 404 if there are no books available" do
      get books_path
    end
  end
  
  describe "show" do
    it 'responds with a success when id given exists' do
      valid_passenger = Passenger.create(name: "Valid Passenger")
      
      get passenger_path(valid_passenger.id)
      
      must_respond_with :success
      
    end
    
    it 'responds with a not_found when id given does not exist' do
      get passenger_path("500")
      
      must_respond_with :not_found
    end
    
  end
end

describe "new" do
  # Your tests go here
end

describe "create" do
  # Your tests go here
end

describe "edit" do
  # Your tests go here
end

describe "update" do
  # Your tests go here
end

describe "destroy" do
  # Your tests go here
end
end
