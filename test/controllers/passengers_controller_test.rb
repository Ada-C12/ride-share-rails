require "test_helper"

describe PassengersController do
  let (:passenger) {
  Passenger.create name: "Test Passenger", phone_num: "360-456-9875"
}
describe "index" do
  
  it "can get the index path" do
    get passengers_path
    
    must_respond_with :success
  end
end

describe "show" do
  
  it "can get a valid passenger" do
    get passenger_path(passenger.id)
    
    must_respond_with :success
  end
  
  it "will redirect for an invalid id"
  
  get passenger_path(-1)
  
  must_respond_with :redirect
  expect(flash[:error]).must_equal "Could not find passenger"
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
