require "test_helper"

describe PassengersController do
  let (:passenger1) { Passenger.create( name: "Ned Flanders", phone_num: "206-123-1234") }
  let (:passenger_hash) {{ passenger: { name: "Homer Simpson", phone_num: "425-123-1234" } }}
  
  describe "index" do
    it "can go to Passengers/index" do
      get passengers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can go to Passengers/:id/show for valid id" do
      passenger1
      get passenger_path(id: passenger1.id)
      must_respond_with :success
    end
    
    it "redirect to homepage if invalid id" do
      get passenger_path(id: -666)
      must_redirect_to nope_path
    end
  end
  
  describe "new" do
    it "can go to Passengers/new.html" do
      get new_passenger_path
      must_respond_with :success
    end
    
    it "can create new Passenger, given correct args, and go to show.html" do
      expect {post passengers_path, params: passenger_hash}.must_change "Passenger.count", 1
      new_passenger = Passenger.last
      must_redirect_to passenger_path(id: new_passenger.id)
      assert (new_passenger.name == passenger_hash[:passenger][:name])
      assert (new_passenger.phone_num == passenger_hash[:passenger][:phone_num])
    end
    
    it "Bad args will fail validations, and user will stay on page" do
      bad_names = [nil, "", "    "]
      
      bad_names.each do |bad_name|
        bad_params = { passenger: {name: bad_name, phone_num: "4251231234"} } 
        expect {post passengers_path, params: bad_params }.must_differ, "Task.count", 0
        must_respond_with 200
      end
      
      # bad_phone_nums = ["garbage", "!!!!!", "123"]
    end
  end
  
  
  describe "create" do
    it "will make new Passenger obj correctly with good args" do
    end
    
    it "will not make Passenger obj and give errors with bad args" do
    end
  end
  
  #   describe "edit" do
  #     # Your tests go here
  #   end
  
  #   describe "update" do
  #     # Your tests go here
  #   end
  
  #   describe "destroy" do
  #     # Your tests go here
  #   end
end
