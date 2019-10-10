require "test_helper"

describe PassengersController do
  let (:example_passenger)  {             
  Passenger.create(name: "Ursula Le Guin", phone_num: "320-444-5555") 
}
describe "index" do
  it "gives back a successful response" do 
    get passengers_path
    must_respond_with :success
    
    #how do we test for not found?
  end
end 
describe "show" do
  it "responds with a success when id given exists" do 
    get passenger_path(example_passenger.id)
    must_respond_with :success
  end
  
  it "responds with a not_found when id given doesn't exist" do 
    get passenger_path("57204")
    must_respond_with :not_found
  end 
end 

describe "new" do
  it "can get the new passenger page" do 
    get new_passenger_path 
    must_respond_with :success
  end 
end

describe "create" do
  it 'creates a new passenger successfully with valid data, and redirects to the passengers page' do 
    passenger_hash = {
    passenger: {
    name: "I Exist",
    phone_num: "320-333-4444" 
  } 
}
expect {
post passengers_path, params: passenger_hash}.must_differ 'Passenger.count', 1
must_redirect_to passengers_path 
end
end 

describe "edit" do
  it "can get the edit page for an existing passenger" do 
    get edit_passenger_path(example_passenger.id)
  end
end 

describe "update" do 
  it "updates an existing passenger and redirects to passengers list" do 
    ursula = example_passenger
    updated_passenger_data = {
    passenger: {
    name: "Updated name",
    phone_num: "999-999-9999"
  }
}
expect { patch passenger_path(ursula.id), params: updated_passenger_data }.wont_change 'Passenger.count'
must_respond_with :redirect

expect (Passenger.find(ursula.id).name).must_equal "Updated name"
expect (Passenger.find(ursula.id).phone_num).must_equal "999-999-9999"
end 
end 

describe "destroy" do
  it "can destroy a passenger" do 
    ursula = example_passenger
    expect { delete passenger_path(ursula.id) }.must_change 'Passenger.count'
    must_respond_with :redirect
    
    get passenger_path(ursula.id)
    must_respond_with :missing
  end 
end
end


